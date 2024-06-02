//
//  APIEndpoint.swift
//  WeatherApp
//
//  Created by Thắng Đặng on 6/2/24.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://api.openweathermap.org"

    case coordinatesByLocationName(String)
    case weatherByLaton(Double, Double)

    private var path: String {
        switch self {
        case .coordinatesByLocationName(let city):
            return "/geo/1.0/direct?q=\(city)&appid=\(Constants.weatherAPIKey)"
        case .weatherByLaton(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.weatherAPIKey)"
        }
    }

    static func endpointUrl(for endpoint: APIEndpoint) -> URL {
        let endpointPath = endpoint.path
        return URL(string: baseURL + endpointPath)!
    }
}
