//
//  Movie.swift
//  MovieAppKit
//
//  Created by Thắng Đặng on 6/17/24.
//

import Foundation

struct MovieResponse: Decodable {
    let Search: [Movie]
}

struct Movie: Identifiable, Decodable {
    let imdbId: String
    let title: String
    let year: String
    let poster: URL?
    var id: String {
        imdbId
    }

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
}
