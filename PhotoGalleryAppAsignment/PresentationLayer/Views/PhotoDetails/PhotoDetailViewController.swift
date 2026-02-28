//
//  PhotoDetailViewController.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    private let imageView = UIImageView()
       private let textField = UITextField()
       private let saveButton = UIButton(type: .system)

       private let viewModel: PhotoDetailViewModel

       init(viewModel: PhotoDetailViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) not implemented")
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           title = "Edit Photo"
           view.backgroundColor = .white

           setupUI()
           bindData()
       }

       private func setupUI() {
           imageView.translatesAutoresizingMaskIntoConstraints = false
           textField.translatesAutoresizingMaskIntoConstraints = false
           saveButton.translatesAutoresizingMaskIntoConstraints = false

           imageView.contentMode = .scaleAspectFit
           
           textField.borderStyle = .roundedRect
           
           saveButton.setTitle("Save", for: .normal)
           saveButton.backgroundColor = .systemTeal
           saveButton.setTitleColor(.white, for: .normal)
           saveButton.layer.cornerRadius = 5

           saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)


           view.addSubview(imageView)
           view.addSubview(textField)
           view.addSubview(saveButton)
        

           NSLayoutConstraint.activate([
            
               imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               imageView.heightAnchor.constraint(equalToConstant: 250),
               imageView.widthAnchor.constraint(equalToConstant: 350),

               textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
               textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               textField.heightAnchor.constraint(equalToConstant: 40),

               saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
               saveButton.heightAnchor.constraint(equalToConstant: 40),
               saveButton.widthAnchor.constraint(equalToConstant: 100),
               saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

           ])
       }

       private func bindData() {
           textField.text = viewModel.photo.title
           imageView.loadImage(url: viewModel.photo.url ?? "")
           //imageView.loadImage(url: "https://picsum.photos/id/237/350/250")
           
           
       }

       @objc private func saveTapped() {
           guard let title = textField.text, !title.isEmpty else { return }
           viewModel.updateTitle(title)
           navigationController?.popViewController(animated: true)
       }
}
