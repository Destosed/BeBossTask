import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class RemoteDataManager {
    
    private static let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    private static let openWeatherMapAPIKey = "0c4c3e3f13b8fab197f68e3b5df8707c"
    
    static func retrieveCity(cityName: String) {
        
        let stringUrl = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(cityName)"
        let requestUrl = URL(string: stringUrl)!
        
        getWeatherByUrl(requestUrl: requestUrl)
        
    }
    
    static func retrieveCity(latitude: Double, longitude: Double) {
        
        let stringUrl = "\(openWeatherMapBaseURL)?lat=" + "\(latitude)&lon=\(longitude)&appid=\(openWeatherMapAPIKey)"
        let requestUrl = URL(string: stringUrl)!
        
        getWeatherByUrl(requestUrl: requestUrl)
        
    }
    
    //Retrieves city and adds it to to the Local Data Manager
    private static func getWeatherByUrl(requestUrl: URL) {
        
        Alamofire.request(requestUrl).responseJSON { (response) in
            
            guard let data = response.result.value else {
                return
            }
            let dictJSON = JSON(data).dictionaryValue
            guard let name = dictJSON["name"]?.stringValue else {
                presentIncorrectCityAllert()
                return
            }
            let temp = dictJSON["main"]!["temp"].int16Value - 273 //Temperature in celsius
            let windSpeed = dictJSON["wind"]!["speed"].int16Value
            let windDirection = dictJSON["wind"]!["deg"].int16Value
            let wheatherImage = dictJSON["weather"]![0]["icon"].stringValue
            
            if LocalDataManager.isCityAllreadyAdded(cityName: name) {
                presentCityAllreadyAddedAlert()
                return
            }
            
            let cityToReturn = City(context: PersistenceService.context)
            cityToReturn.name = name
            cityToReturn.temp = temp
            cityToReturn.windSpeed = windSpeed
            cityToReturn.windDirection = windDirection
            cityToReturn.whetherImage = wheatherImage
            PersistenceService.saveContext()
            
            HUD.flash(.success, delay: 1.5)
            
        }
        
    }
    
    //MARK: - AlertControllers
    
    private static func presentCityAllreadyAddedAlert() {
        
        let cityAllreadyAddedAlert = UIAlertController(title: "Error", message: "City allready added", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        cityAllreadyAddedAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(cityAllreadyAddedAlert, animated: true, completion: nil)
        
    }
    
    private static func presentIncorrectCityAllert() {
        
        let incorrectCityAllert = UIAlertController(title: "Error", message: "Incorrect city", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        incorrectCityAllert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(incorrectCityAllert, animated: true, completion: nil)
        
    }
    
}
