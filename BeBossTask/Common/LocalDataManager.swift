import Foundation
import CoreData

class LocalDataManager {
    
    static func retrieveCities() -> [City] {
        
        var citiesList: [City] = []
        
        do {
            let fetchReq: NSFetchRequest<City> = City.fetchRequest()
            citiesList = try PersistenceService.context.fetch(fetchReq)
        } catch {
            //Error handling
        }
        return citiesList
        
    }
    
    //Retrieves cities and adds them to the Local Data Manager
    static func updateLocalDataManagerInfo(for cities: [City]) {
        
        PersistenceService.clearContext()
        
        for city in cities {
            RemoteDataManager.retrieveCity(cityName: city.name!)
        }
        
    }
    
    static func isCityAllreadyAdded(cityName: String) -> Bool {
        
        let cities = self.retrieveCities()
        
        for city in cities {
            if city.name == cityName { return true }
        }
        
        return false
        
    }
    
}
