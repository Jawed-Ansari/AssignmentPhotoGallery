//
//  PhotoListViewModel.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import Foundation

final class PhotoListViewModel {

    private let repository: PhotoRepositoryProtocol
    private(set) var photos: [PhotoEntity] = []

    private var currentPage = 0
    private let pageSize = 30

    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    init(repository: PhotoRepositoryProtocol) {
        self.repository = repository
    }

    func loadInitialData() {
        photos = repository.fetchLocalPhotos()

        if photos.isEmpty {
            fetchNextPage()
        } else {
            onDataUpdate?()
        }
    }

    func fetchNextPage() {
        repository.fetchRemotePhotos(start: currentPage * pageSize,
                                      limit: pageSize) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.photos = self?.repository.fetchLocalPhotos() ?? []
                    self?.currentPage += 1
                    self?.onDataUpdate?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}

