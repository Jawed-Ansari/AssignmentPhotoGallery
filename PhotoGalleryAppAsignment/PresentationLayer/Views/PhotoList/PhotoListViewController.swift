//
//  PhotoListViewController.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import UIKit

class PhotoListViewController: UIViewController {

    private let tableView = UITableView()
    private let loader = UIActivityIndicatorView(style: .large)

    private let repository = PhotoRepository(network: NetworkService())
    private lazy var viewModel = PhotoListViewModel(repository: repository)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        view.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        setupTableView()
        setupLoader()
        bindViewModel()

        loader.startAnimating()
        viewModel.loadInitialData()
    }
    override func viewDidAppear(_ animated: Bool) {
        //viewModel.loadInitialData()
    }
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    private func setupLoader() {
        loader.center = view.center
        view.addSubview(loader)
    }

    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            self?.loader.stopAnimating()
            self?.tableView.reloadData()
        }

        viewModel.onError = { [weak self] message in
            self?.loader.stopAnimating()
            self?.showAlert(message)
        }
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    



}
extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.photos.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: PhotoListTableViewCell.identifier,
            for: indexPath
        ) as! PhotoListTableViewCell

        let photo = viewModel.photos[indexPath.row]
        cell.configure(photo: photo)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let photo = viewModel.photos[indexPath.row]
        let detailVM = PhotoDetailViewModel(photo: photo,
                                            repository: repository)
        detailVM.onUpdate = { [weak self] in
            self?.viewModel.loadInitialData()
        }
        let vc = PhotoDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(vc, animated: true)
    }

    // Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height * 2 {
            viewModel.fetchNextPage()
        }
    }

    // Swipe to delete
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            deleteTapped(indexPath: indexPath.row)
//            let photo = viewModel.photos[indexPath.row]
//            repository.delete(photo: photo)
//            viewModel.loadInitialData()
        }
    }
    
    private func deleteTapped(indexPath: Int) {
        let alert = UIAlertController(title: "Delete",
                                      message: "Are you sure?",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            //self.viewModel.deletePhoto()
            
            let photo = self.viewModel.photos[indexPath]
            self.repository.delete(photo: photo)
            self.viewModel.loadInitialData()
        })

        present(alert, animated: true)
    }
}
