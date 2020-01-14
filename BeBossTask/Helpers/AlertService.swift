import Foundation
import UIKit

class AlertService {
    
    static func presentInfoAlert(on vc: UIViewController, message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    static func presentAuthorizationProblemAlert(on vc: UIViewController) {
        
        let errorAllert = UIAlertController(title: "Location disables", message: "Please, check authorization status in settings", preferredStyle: .alert)

        let openSettingsAction = UIAlertAction(title: "Settings", style: .default) { (UIAlertAction) in
            // Open the settings of your app
            if let url = NSURL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url as URL)
            }
        }
        let cancelActon = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        errorAllert.addAction(openSettingsAction)
        errorAllert.addAction(cancelActon)
        vc.present(errorAllert, animated: true, completion: nil)
    }
}
