import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var cityImageImage: UIImageView!
    @IBOutlet weak var cityWindSpeedLabel: UILabel!
    @IBOutlet weak var cityWindDirectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = mainView.frame.height / 10
        mainView.clipsToBounds = true
        
    }

    func setForCity(city: City) {
        
        cityNameLabel.text = city.name
        cityTemperatureLabel.text = String("\(city.temp)°")
        cityWindSpeedLabel.text = String("\(city.windSpeed) m/s")
        cityImageImage.image = UIImage(named: city.whetherImage)
        cityWindDirectionLabel.text = city.windDirection
        
    }
}
