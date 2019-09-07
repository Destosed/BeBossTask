import UIKit
import CoreData

class CityListViewController: UIViewController {

    @IBOutlet weak var cityListTableView: UITableView!
    
    var citiesList: [City] = []
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTableView()
        setupRefresher()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        citiesList = LocalDataManager.retrieveCities()
        cityListTableView.reloadData()
        
    }
    
    @IBAction func addCityButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddCityVC", sender: self)
    }
    
}

extension CityListViewController {
    
    func setupRefresher() {
    
        if #available(iOS 10.0, *) {
            cityListTableView.refreshControl = refreshControl
        } else {
            cityListTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
    
    @objc private func refreshData() {
        LocalDataManager.updateLocalDataManagerInfo(for: self.citiesList)
        self.cityListTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
}

//MARK: - TableView extension

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersistenceService.context.delete(citiesList[indexPath.row])
            citiesList.remove(at: indexPath.row)
            self.cityListTableView.reloadData()
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

