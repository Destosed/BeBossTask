import UIKit

class CityListViewController: UIViewController {

    @IBOutlet weak var cityListTableView: UITableView!
    
    var citiesList: [String] = ["", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }

    @IBAction func addCityButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddCityVC", sender: self)
    }
    
}

//MARK: - TableView extension

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cityListTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CityTableViewCell
        cell.layer.cornerRadius = cell.frame.height / 10
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        
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

