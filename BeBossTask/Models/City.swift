import Foundation

struct City: Codable {
    
    let name: String
    let temp: Int
    let windSpeed: Int
    let windDirection: String
    let whetherImage: String
    
    init(name: String, temp: Int, windSpeed: Int, windDirection: String, whetherImage: String) {
        
        self.name = name
        self.temp = temp
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.whetherImage = whetherImage
    }
}
