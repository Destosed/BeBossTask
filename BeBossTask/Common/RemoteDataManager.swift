import Foundation
import Alamofire
import SwiftyJSON

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
            let name = dictJSON["name"]!.stringValue
            let temp = dictJSON["main"]!["temp"].int16Value - 273 //Temperature in celsius
            let windSpeed = dictJSON["wind"]!["speed"].int16Value
            let windDirection = dictJSON["wind"]!["deg"].int16Value
            let wheatherImage = dictJSON["weather"]![0]["icon"].stringValue
            
            if LocalDataManager.isCityAllreadyAdded(cityName: name) {
                //City allready added
                return
            }
            
            let cityToReturn = City(context: PersistenceService.context)
            cityToReturn.name = name
            cityToReturn.temp = temp
            cityToReturn.windSpeed = windSpeed
            cityToReturn.windDirection = windDirection
            cityToReturn.whetherImage = wheatherImage
            PersistenceService.saveContext()
            
        }
        
    }
    
}
