import UIKit
import MapKit

class AddCityViewController: UIViewController {
    
    weak var cityListDelegate: CityListDelegate!
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
        
        var cityName = addCityTextField.text!
        guard cityName != "" else {
            return
        }
        cityName = cityName.trimmingCharacters(in: .whitespaces) // Clearing extra spaces
        
        RemoteDataManager.shared.retrieveCity(cityName: cityName) { city in
            
            if let city = city {
                self.cityListDelegate.addCity(city: city)
                self.navigationController?.popViewController(animated: true)
            } else {
                AlertService.presentInfoAlert(on: self, message: "Couldn't retrieve city")
            }
        }
    }
    
    @IBAction func findCityByGpsButtonPressed(_ sender: Any) {
        self.findCityByGps()
    }
}

//MARK: - CLLocation

extension AddCityViewController: CLLocationManagerDelegate {
    
    //Doesn't work in simulator
    func findCityByGps() {
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        guard authorizationStatus == .authorizedWhenInUse else {
            AlertService.presentAuthorizationProblemAlert(on: self)
            return
        }
        
        locationManager.requestWhenInUseAuthorization()
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        guard let coordinates = locationManager.location?.coordinate else {
            
            //TODO: Handle Error
            return
        }
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        
        RemoteDataManager.shared.retrieveCity(latitude: latitude, longitude: longitude) { city in
            if let city = city {
                self.cityListDelegate.addCity(city: city)
                self.navigationController?.popViewController(animated: true)
            } else {
                AlertService.presentInfoAlert(on: self, message: "Couldn't retrieve city")
            }
        }
    }
}

//MARK: - textField delegates

extension AddCityViewController: UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCityTextField.resignFirstResponder()
        return true
    }
}
