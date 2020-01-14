import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class RemoteDataManager {
    
    static let shared = RemoteDataManager()
    
    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "0c4c3e3f13b8fab197f68e3b5df8707c"
    
    //Get city by its name
    func retrieveCity(cityName: String, complition: @escaping (City?) -> ()) {

        let stringUrl = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(cityName)"
        let requestUrl = URL(string: stringUrl)!
        
        Alamofire.request(requestUrl).responseJSON { (response) in
            
            guard let data = response.result.value else {
                complition(nil)
                return
            }
            let dictJSON = JSON(data).dictionaryValue
            guard let name = dictJSON["name"]?.stringValue else {
                complition(nil)
                return
            }
            let temp = dictJSON["main"]!["temp"].intValue - 273 //Temperature in celsius
            let windSpeed = dictJSON["wind"]!["speed"].intValue
            let windDirection = dictJSON["wind"]!["deg"].doubleValue
            let wheatherImage = dictJSON["weather"]![0]["icon"].stringValue
            
            let stringWindDirection = Helper.convertDegreesToDirection(for: windDirection)
            
            let cityToReturn = City(name: name, temp: temp, windSpeed: windSpeed, windDirection: stringWindDirection, whetherImage: wheatherImage)
            
            complition(cityToReturn)
        }
    }
    
    //Get city by its coorinates
    func retrieveCity(latitude: Double, longitude: Double, complition: @escaping (City?) -> ()) {

        let stringUrl = "\(openWeatherMapBaseURL)?lat=" + "\(latitude)&lon=\(longitude)&appid=\(openWeatherMapAPIKey)"
        let requestUrl = URL(string: stringUrl)!

        Alamofire.request(requestUrl).responseJSON { (response) in
            
            guard let data = response.result.value else {
                //Connection problem
                return
            }
            let dictJSON = JSON(data).dictionaryValue
            let name = dictJSON["name"]!.stringValue
            let temp = dictJSON["main"]!["temp"].intValue - 273 //Temperature in celsius
            let windSpeed = dictJSON["wind"]!["speed"].intValue
            let windDirection = dictJSON["wind"]!["deg"].doubleValue
            let wheatherImage = dictJSON["weather"]![0]["icon"].stringValue
            
            let stringWindDirection = Helper.convertDegreesToDirection(for: windDirection)
            
            let cityToReturn = City(name: name, temp: temp, windSpeed: windSpeed, windDirection: stringWindDirection, whetherImage: wheatherImage)
            
            complition(cityToReturn)
        }
    }
}
