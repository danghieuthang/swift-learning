//
//  WebService.swift
//  MovieAppKit
//
//  Created by Thắng Đặng on 6/17/24.
//

import Combine
import Foundation

enum NetworkError: Error {
    case badUrl
    case badRequest
    case decodingError
}

struct WebService {
    func fetchMovies(search: String) -> AnyPublisher<[Movie], Error> {
        guard let encodedSearch = search.urlEncoded else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }

        let url = URL(string: "https://www.omdbapi.com/?s=\(encodedSearch)&page=2&apiKey=ce157249")

        return URLSession.shared.dataTaskPublisher(for: url!)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .catch { _ -> AnyPublisher<[Movie], Error> in
                Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
