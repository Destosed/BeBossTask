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
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        guard authorizationStatus == .authorizedWhenInUse else {
            presentAuthorizationProblemAlert()
            return
        }
        
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
    
    func presentAuthorizationProblemAlert() {
        let errorAllert = UIAlertController(title: "Location disables", message: "Please, check authorization status in settings", preferredStyle: .alert)
        let okErrorAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAllert.addAction(okErrorAlert)
        present(errorAllert, animated: true, completion: nil)
    }
    
}
