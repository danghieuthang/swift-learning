//
//  WeatherClient.swift
//  WeatherApp
//
//  Created by Thắng Đặng on 6/2/24.
//

import Foundation

struct WeatherClient {
    func fetchWeather(location: Location) async throws -> Weather {
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endpointUrl(for: .weatherByLaton(location.lat, location.lon)))

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weatherResponse.main
    }
}
