import UIKit
import CoreData

class CityListViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var cityListTableView: UITableView!
    
    //MARK: - Properties
    
    var citiesList: [City] = []
    
    let label = UILabel()
    
    //MARK: - IBActions
    
    @IBAction func addCityButtonPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addCityVC = storyboard.instantiateViewController(withIdentifier: "AddCityViewController") as! AddCityViewController
        addCityVC.cityListDelegate = self
        navigationController?.pushViewController(addCityVC, animated: true)
    }
    
    //MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !citiesList.isEmpty {
            label.removeFromSuperview()
        } else {
            setupTextLabel()
        }
        cityListTableView.reloadData()
    }
    
    //MARK: - Helpers
    
    func setupTextLabel() {
        
        self.view.addSubview(label)
        
        label.text = "Press plus button to add the city"
        label.font = UIFont (name: "HelveticaNeue-UltraLight", size: 25)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

//MARK: - TableView extension

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            citiesList.remove(at: indexPath.row)
            cityListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cityListTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CityTableViewCell
        cell.layer.cornerRadius = cell.frame.height / 10
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        
        if citiesList.count != 0 {
            cell.setForCity(city: citiesList[indexPath.row])
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 248.0
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    

    func setupTableView() {
        
        let nibCell = UINib(nibName: "CityTableViewCell", bundle: nil)
        self.cityListTableView.register(nibCell, forCellReuseIdentifier: "myCell")
        self.cityListTableView.tableFooterView = UIView(frame: .zero)
        cityListTableView.separatorColor = .white
    }
}

extension CityListViewController: CityListDelegate {
    
    func addCity(city: City) {
        
        if citiesList.contains(where: { $0.name == city.name }) {
            AlertService.presentInfoAlert(on: self, message: "City allready added")
        } else {
            self.citiesList.append(city)
        }
    }
}
