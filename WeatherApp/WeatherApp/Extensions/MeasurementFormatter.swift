//
//  MeasurementFormatter.swift
//  WeatherApp
//
//  Created by Thắng Đặng on 6/2/24.
//

import Foundation

extension MeasurementFormatter {
    static func temperature(value: Double) -> String {
        let numberFormmater = NumberFormatter()
        numberFormmater.maximumFractionDigits = 0

        let formatter = MeasurementFormatter()
        formatter.numberFormatter = numberFormmater

        let temp = Measurement(value: value, unit: UnitTemperature.kelvin)

        return formatter.string(from: temp)
    }
}
