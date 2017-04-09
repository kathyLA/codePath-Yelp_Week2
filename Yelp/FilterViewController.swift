//
//  FilterViewController.swift
//  Yelp
//
//  Created by kathy yin on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//


import UIKit

@objc protocol FilterViewControllerDelegate {
    @objc optional func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject])
}

enum SectionIdentifier: String {
    case OfferingDeal = "Offering a Deal"
    case Distance = "Distance"
    case Sort = "Sort By"
    case Categories = "Categroy"
    
    func showSectionTitle() -> Bool {
      switch(self) {
        case .OfferingDeal:
            return false
        case .Distance:
            return true
        case .Sort:
            return true
        case .Categories:
            return true
      }
    }
}

enum Distance: NSNumber {
    case Auto = 0
    case Distance1 = 0.3
    case Distance2 = 1
    case Distance3 = 5
    case Distance4 = 20
    
    func distanceLabel() -> String{
        switch (self) {
            case .Auto:
              return "Auto"
            case .Distance1:
               return "0.3 mi"
            case .Distance2:
              return "1 mi"
            case .Distance3:
                return "5 mi"
            case .Distance4:
                return "20 mi"
            
        }
    }
}

extension YelpSortMode {
    func sortLabel() -> String {
        switch self {
            case .bestMatched:
                    return "Best Match"
            case .distance:
                    return "Distance"
            case .highestRated:
                    return "Rated"
        }
    }
}

class FilterViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate, FilterViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    let tableSection: [SectionIdentifier] = [.OfferingDeal, .Distance, .Sort , .Categories]
    
    let distanceFilters: [Distance] = [.Auto,.Distance1,.Distance2,.Distance3, .Distance4]
    let sortFilters:[YelpSortMode] = [.bestMatched, .distance, .highestRated]
    
    let defaultCategories = 3
    
    var selectDistanceIndex = 0
    var dealSwitchStatus = false
    var sortSelectIndex = 0

    
    var tableStruct:[String: AnyObject] = [:]
    var categories: [[String: String]]!
    var categoriesSwitchState: [Int: Bool] = [:]
    weak var delegate: FilterViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        categories = []
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSection.count
    }
    
    @IBAction func onTapSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let filters = [String:AnyObject]()
        delegate?.filterViewController?(filterViewController: self, didUpdateFilters: filters)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch  tableSection[section] {
            case .OfferingDeal:
                return 1
            case .Distance:
                return distanceFilters.count
            case .Sort:
                 return sortFilters.count
            default:
                return categories.count
        }
    }
    
    func SwitchCell(switchCell: SwitchCell, didChangeValue: Bool) {
        //let indexPath = tableView.indexPath(for: switchCell)!
        //switchState[indexPath.row] = didChangeValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (tableSection[indexPath.section]){
            case .OfferingDeal:
                let displayString = "Offering a Deal"
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
                cell.switchLabel.text = displayString
                return cell
            case .Distance:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckButtonCell") as! CheckButtonCell
                return cell
            case .Sort:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckButtonCell") as! CheckButtonCell
                return cell
            case .Categories:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
                return cell
         }
        
            /*let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as? SwitchCell
            cell?.delegate = self
            let on = switchState[indexPath.row] ?? false
            cell?.settingSwitch.setOn(on, animated: false)
            return cell!*/
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "test"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let navigationController = segue.destination as? UINavigationController
            let filterViewController = navigationController?.topViewController as? FilterViewController
            filterViewController?.delegate = self
        
    }
    
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
