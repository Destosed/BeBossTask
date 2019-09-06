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
    
    static func saveCities(cities: [City]) {
        
        PersistenceService.saveContext()
        
    }
}
