import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = mainView.frame.height / 6
        mainView.clipsToBounds = true
        
    }

}
