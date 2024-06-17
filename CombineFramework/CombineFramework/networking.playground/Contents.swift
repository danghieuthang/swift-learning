import Combine
import UIKit

struct Post: Codable {
    let userId: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badServerResponse
}

func fetchPosts() -> AnyPublisher<[Post], Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.badServerResponse
            }
            return data
        }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .retry(3)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

var cancellables: Set<AnyCancellable> = []

fetchPosts()
    .sink { completion in
        switch completion {
        case .finished:
            print("update ui")
        case .failure(let error):
            print(error)
        }
    } receiveValue: { posts in
        print(posts)
    }
    .store(in: &cancellables)
