import Combine
import UIKit

struct Movie: Decodable {
    let title: String
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}

struct MovieResponse: Decodable {
    let Search: [Movie]
}

func fetchMovie(_ searchTerm: String) -> AnyPublisher<MovieResponse, Error> {
    let url = URL(string: "https://www.omdbapi.com/?s=\(searchTerm)&page=2&apiKey=ce157249")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieResponse.self, decoder: JSONDecoder())
        .retry(3)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

var cancellables: Set<AnyCancellable> = []

Publishers.CombineLatest(fetchMovie("Batman"), fetchMovie("Spiderman"))
    .sink { _ in

    } receiveValue: { value1, value2 in
        print(value1.Search)
        print(value2.Search)
    }
