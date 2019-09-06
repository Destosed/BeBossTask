import Foundation

class RemoteDataManager {
    
    static func retrieveCities() -> [City] {
        
        var citiesList: [City] = []
        
        //TODO: ...
        
        LocalDataManager.saveCities(cities: citiesList)
        return citiesList
        
    }

}
