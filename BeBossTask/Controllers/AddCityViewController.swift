import UIKit
import MapKit

class AddCityViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        findCityByGpsButton.layer.cornerRadius = findCityByGpsButton.frame.height / 4
    }

    //MARK: - Outlets
    @IBOutlet weak var addCityTextField: UITextField!
    @IBOutlet weak var findCityByGpsButton: UIButton!
    
    //MARK: - Actions
    @IBAction func addCityButtonPressed(_ sender: Any) {
        
        RemoteDataManager.retrieveCity(cityName: addCityTextField.text!)
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func findCityByGpsButtonPressed(_ sender: Any) {

        self.findCityByGps()
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddCityViewController: CLLocationManagerDelegate {
    
    //Doesn't work in simulator
    
    func findCityByGps() {
        
        locationManager.requestWhenInUseAuthorization()
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        let coordinates = locationManager.location?.coordinate
        let latitude = coordinates?.latitude
        let longitude = coordinates?.longitude
        
        RemoteDataManager.retrieveCity(latitude: latitude!, longitude: longitude!)
        
    }
    
}
