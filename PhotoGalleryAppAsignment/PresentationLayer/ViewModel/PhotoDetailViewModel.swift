//
//  PhotoDetailViewModel.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import Foundation

final class PhotoDetailViewModel {

    private let repository: PhotoRepositoryProtocol
    let photo: PhotoEntity
    var onUpdate: (() -> Void)?

    init(photo: PhotoEntity, repository: PhotoRepositoryProtocol) {
        self.photo = photo
        self.repository = repository
    }

    func updateTitle(_ title: String) {
        repository.update(photo: photo, title: title)
        onUpdate?()
    }

    func deletePhoto() {
        repository.delete(photo: photo)
    }
}
