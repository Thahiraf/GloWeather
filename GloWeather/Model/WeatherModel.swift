//
//  WeatherModel.swift
//  GloWeather
//
//  Created by Thahi on 18/06/2021.
//

import Foundation
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    //temperature 1 decimal point
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    //Weather images id from API
    var ConditionName:String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

