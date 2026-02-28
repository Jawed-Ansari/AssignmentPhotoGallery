//
//  PhotoRepositoryProtocol.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import Foundation

protocol PhotoRepositoryProtocol {
    func fetchLocalPhotos() -> [PhotoEntity]
    func fetchRemotePhotos(start: Int, limit: Int,
                            completion: @escaping (Result<Void, Error>) -> Void)
    func update(photo: PhotoEntity, title: String)
    func delete(photo: PhotoEntity)
}

