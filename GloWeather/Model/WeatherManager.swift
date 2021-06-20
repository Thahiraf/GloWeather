//
//  WeatherManager.swift
//  GloWeather
//
//  Created by Thahi on 15/06/2021.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
    }
struct WeatherManager {
    //API KEY not excluded
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude:CLLocationDegrees, longitude:CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        
    }
        
        func performRequest(with urlString: String){
            
            //create URL
            if let url = URL(string: urlString){
                
                //create a URLsession
                let session = URLSession(configuration: .default)
                
                //Give the session a task
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil{
                        self.delegate?.didFailWithError(error: error!)
                        print(error!)
                        return
                    }
                    if let safeData = data{
                        if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    }
                }
                
                //start the task
                task.resume()
            }
        }
        
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
    
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
            
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
