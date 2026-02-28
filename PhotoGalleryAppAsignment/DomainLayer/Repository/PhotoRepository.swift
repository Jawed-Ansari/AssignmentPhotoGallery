//
//  PhotoRepository.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import Foundation
import CoreData

final class PhotoRepository: PhotoRepositoryProtocol {

    private let network: NetworkServiceProtocol
    private let context = CoreDataStack.shared.context

    init(network: NetworkServiceProtocol) {
        self.network = network
    }

    func fetchLocalPhotos() -> [PhotoEntity] {
        let request: NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func fetchRemotePhotos(start: Int, limit: Int,
                            completion: @escaping (Result<Void, Error>) -> Void) {

        network.fetchPhotos(start: start, limit: limit) { result in
            switch result {
            case .success(let dtos):
                self.savePhotos(dtos)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func savePhotos(_ dtos: [PhotoDTO]) {
        dtos.forEach { dto in
            let request: NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", dto.id)

            if let exists = try? context.fetch(request), !exists.isEmpty {
                return
            }

            let photo = PhotoEntity(context: context)
            photo.id = Int64(dto.id)
            photo.albumId = Int64(dto.albumId)
            photo.title = dto.title
            photo.url = dto.url
            photo.thumbnailUrl = dto.thumbnailUrl
        }
        CoreDataStack.shared.save()
    }

    func update(photo: PhotoEntity, title: String) {
        photo.title = title
        CoreDataStack.shared.save()
    }

    func delete(photo: PhotoEntity) {
        context.delete(photo)
        CoreDataStack.shared.save()
    }
}
