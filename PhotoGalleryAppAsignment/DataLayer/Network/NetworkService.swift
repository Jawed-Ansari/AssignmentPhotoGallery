//
//  NetworkService.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchPhotos(start: Int, limit: Int,
                     completion: @escaping (Result<[PhotoDTO], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

    func fetchPhotos(start: Int, limit: Int,
                     completion: @escaping (Result<[PhotoDTO], Error>) -> Void) {

        let urlString = "https://jsonplaceholder.typicode.com/photos?_start=\(start)&_limit=\(limit)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error)); return
            }

            guard let data else { return }
            do {
                let photos = try JSONDecoder().decode([PhotoDTO].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
