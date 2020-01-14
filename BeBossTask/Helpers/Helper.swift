import Foundation

class Helper {
    
    static func convertDegreesToDirection(for degrees: Double) -> String {
        
        let directions = ["North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"]
        let index = Int((degrees + 22.5) / 45.0) & 7
        return directions[index]
    }
}
