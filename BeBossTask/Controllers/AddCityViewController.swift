import UIKit
import SearchTextField

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var mySearchTextField: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchTextField()
    }
    
    func setupSearchTextField() {
        
        mySearchTextField.borderStyle = .roundedRect
        mySearchTextField.clipsToBounds = true
        
        mySearchTextField.filterStrings(["Red", "Blue", "Yellow"])
        
    }

}
