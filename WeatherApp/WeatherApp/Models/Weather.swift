//
//  Weather.swift
//  WeatherApp
//
//  Created by Thắng Đặng on 6/2/24.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
}
