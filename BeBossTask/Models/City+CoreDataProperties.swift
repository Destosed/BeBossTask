import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var temp: Int16
    @NSManaged public var windSpeed: Int16
    @NSManaged public var windDirection: Int16
    @NSManaged public var whetherImage: String?
    
}
