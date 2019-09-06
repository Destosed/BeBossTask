import UIKit

class AddCityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findCityByGpsButton.layer.cornerRadius = findCityByGpsButton.frame.height / 4
    }

    //MARK: - Outlets
    @IBOutlet weak var addCityTextField: UITextField!
    @IBOutlet weak var findCityByGpsButton: UIButton!
    
    //MARK: - Actions
    @IBAction func addCityButtonPressed(_ sender: Any) {
        
    }
    @IBAction func findCityByGpsButtonPressed(_ sender: Any) {
        
    }
    
}
