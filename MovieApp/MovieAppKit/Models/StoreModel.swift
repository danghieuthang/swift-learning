//
//  StoreModel.swift
//  MovieAppKit
//
//  Created by Thắng Đặng on 6/17/24.
//

import Combine
import Foundation

@MainActor
class StoreModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var movies: [Movie] = []
    @Published var loadingComopleted: Bool = false
    private var searchSubject = CurrentValueSubject<String, Never>("")
    private let webService: WebService
    init(webService: WebService) {
        self.webService = webService
        setupSearchPublisher()
    }

    private func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.loadMovies(search: searchText)
            }.store(in: &cancellables)
    }

    func setSearchText(_ searchText: String) {
        searchSubject.send(searchText)
    }

    func loadMovies(search: String) {
        webService.fetchMovies(search: search)
            .sink { completion in
                switch completion {
                case .finished:
                    self.loadingComopleted = true
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }.store(in: &cancellables)
    }
}
