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
    case Categories = "Restaurant Categroy"
    
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
    var restaurantCategories: [[String: String]]!
    var categoriesSwitchState: [Int: Bool] = [:]
    weak var delegate: FilterViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        restaurantCategories = yelpCategories()
        
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
                return restaurantCategories.count
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
                cell.switchLabel.text = (restaurantCategories[indexPath.row])["name"]
                return cell
         }
        
            /*let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as? SwitchCell
            cell?.delegate = self
            let on = switchState[indexPath.row] ?? false
            cell?.settingSwitch.setOn(on, animated: false)
            return cell!*/
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = tableSection[section].rawValue
        return tableSection[section].showSectionTitle() ? title : nil
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

extension FilterViewController {
    func yelpCategories() -> [[String: String]] {
        return [["name" : "Afghan", "code": "afghani"],
                ["name" : "African", "code": "african"],
                ["name" : "American, New", "code": "newamerican"],
                ["name" : "American, Traditional", "code": "tradamerican"],
                ["name" : "Arabian", "code": "arabian"],
                ["name" : "Argentine", "code": "argentine"],
                ["name" : "Armenian", "code": "armenian"],
                ["name" : "Asian Fusion", "code": "asianfusion"],
                ["name" : "Asturian", "code": "asturian"],
                ["name" : "Australian", "code": "australian"],
                ["name" : "Austrian", "code": "austrian"],
                ["name" : "Baguettes", "code": "baguettes"],
                ["name" : "Bangladeshi", "code": "bangladeshi"],
                ["name" : "Barbeque", "code": "bbq"],
                ["name" : "Basque", "code": "basque"],
                ["name" : "Bavarian", "code": "bavarian"],
                ["name" : "Beer Garden", "code": "beergarden"],
                ["name" : "Beer Hall", "code": "beerhall"],
                ["name" : "Beisl", "code": "beisl"],
                ["name" : "Belgian", "code": "belgian"],
                ["name" : "Bistros", "code": "bistros"],
                ["name" : "Black Sea", "code": "blacksea"],
                ["name" : "Brasseries", "code": "brasseries"],
                ["name" : "Brazilian", "code": "brazilian"],
                ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                ["name" : "British", "code": "british"],
                ["name" : "Buffets", "code": "buffets"],
                ["name" : "Bulgarian", "code": "bulgarian"],
                ["name" : "Burgers", "code": "burgers"],
                ["name" : "Burmese", "code": "burmese"],
                ["name" : "Cafes", "code": "cafes"],
                ["name" : "Cafeteria", "code": "cafeteria"],
                ["name" : "Cajun/Creole", "code": "cajun"],
                ["name" : "Cambodian", "code": "cambodian"],
                ["name" : "Canadian", "code": "New)"],
                ["name" : "Canteen", "code": "canteen"],
                ["name" : "Caribbean", "code": "caribbean"],
                ["name" : "Catalan", "code": "catalan"],
                ["name" : "Chech", "code": "chech"],
                ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                ["name" : "Chicken Shop", "code": "chickenshop"],
                ["name" : "Chicken Wings", "code": "chicken_wings"],
                ["name" : "Chilean", "code": "chilean"],
                ["name" : "Chinese", "code": "chinese"],
                ["name" : "Comfort Food", "code": "comfortfood"],
                ["name" : "Corsican", "code": "corsican"],
                ["name" : "Creperies", "code": "creperies"],
                ["name" : "Cuban", "code": "cuban"],
                ["name" : "Curry Sausage", "code": "currysausage"],
                ["name" : "Cypriot", "code": "cypriot"],
                ["name" : "Czech", "code": "czech"],
                ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                ["name" : "Danish", "code": "danish"],
                ["name" : "Delis", "code": "delis"],
                ["name" : "Diners", "code": "diners"],
                ["name" : "Dumplings", "code": "dumplings"],
                ["name" : "Eastern European", "code": "eastern_european"],
                ["name" : "Ethiopian", "code": "ethiopian"],
                ["name" : "Fast Food", "code": "hotdogs"],
                ["name" : "Filipino", "code": "filipino"],
                ["name" : "Fish & Chips", "code": "fishnchips"],
                ["name" : "Fondue", "code": "fondue"],
                ["name" : "Food Court", "code": "food_court"],
                ["name" : "Food Stands", "code": "foodstands"],
                ["name" : "French", "code": "french"],
                ["name" : "French Southwest", "code": "sud_ouest"],
                ["name" : "Galician", "code": "galician"],
                ["name" : "Gastropubs", "code": "gastropubs"],
                ["name" : "Georgian", "code": "georgian"],
                ["name" : "German", "code": "german"],
                ["name" : "Giblets", "code": "giblets"],
                ["name" : "Gluten-Free", "code": "gluten_free"],
                ["name" : "Greek", "code": "greek"],
                ["name" : "Halal", "code": "halal"],
                ["name" : "Hawaiian", "code": "hawaiian"],
                ["name" : "Heuriger", "code": "heuriger"],
                ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                ["name" : "Hot Dogs", "code": "hotdog"],
                ["name" : "Hot Pot", "code": "hotpot"],
                ["name" : "Hungarian", "code": "hungarian"],
                ["name" : "Iberian", "code": "iberian"],
                ["name" : "Indian", "code": "indpak"],
                ["name" : "Indonesian", "code": "indonesian"],
                ["name" : "International", "code": "international"],
                ["name" : "Irish", "code": "irish"],
                ["name" : "Island Pub", "code": "island_pub"],
                ["name" : "Israeli", "code": "israeli"],
                ["name" : "Italian", "code": "italian"],
                ["name" : "Japanese", "code": "japanese"],
                ["name" : "Jewish", "code": "jewish"],
                ["name" : "Kebab", "code": "kebab"],
                ["name" : "Korean", "code": "korean"],
                ["name" : "Kosher", "code": "kosher"],
                ["name" : "Kurdish", "code": "kurdish"],
                ["name" : "Laos", "code": "laos"],
                ["name" : "Laotian", "code": "laotian"],
                ["name" : "Latin American", "code": "latin"],
                ["name" : "Live/Raw Food", "code": "raw_food"],
                ["name" : "Lyonnais", "code": "lyonnais"],
                ["name" : "Malaysian", "code": "malaysian"],
                ["name" : "Meatballs", "code": "meatballs"],
                ["name" : "Mediterranean", "code": "mediterranean"],
                ["name" : "Mexican", "code": "mexican"],
                ["name" : "Middle Eastern", "code": "mideastern"],
                ["name" : "Milk Bars", "code": "milkbars"],
                ["name" : "Modern Australian", "code": "modern_australian"],
                ["name" : "Modern European", "code": "modern_european"],
                ["name" : "Mongolian", "code": "mongolian"],
                ["name" : "Moroccan", "code": "moroccan"],
                ["name" : "New Zealand", "code": "newzealand"],
                ["name" : "Night Food", "code": "nightfood"],
                ["name" : "Norcinerie", "code": "norcinerie"],
                ["name" : "Open Sandwiches", "code": "opensandwiches"],
                ["name" : "Oriental", "code": "oriental"],
                ["name" : "Pakistani", "code": "pakistani"],
                ["name" : "Parent Cafes", "code": "eltern_cafes"],
                ["name" : "Parma", "code": "parma"],
                ["name" : "Persian/Iranian", "code": "persian"],
                ["name" : "Peruvian", "code": "peruvian"],
                ["name" : "Pita", "code": "pita"],
                ["name" : "Pizza", "code": "pizza"],
                ["name" : "Polish", "code": "polish"],
                ["name" : "Portuguese", "code": "portuguese"],
                ["name" : "Potatoes", "code": "potatoes"],
                ["name" : "Poutineries", "code": "poutineries"],
                ["name" : "Pub Food", "code": "pubfood"],
                ["name" : "Rice", "code": "riceshop"],
                ["name" : "Romanian", "code": "romanian"],
                ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                ["name" : "Rumanian", "code": "rumanian"],
                ["name" : "Russian", "code": "russian"],
                ["name" : "Salad", "code": "salad"],
                ["name" : "Sandwiches", "code": "sandwiches"],
                ["name" : "Scandinavian", "code": "scandinavian"],
                ["name" : "Scottish", "code": "scottish"],
                ["name" : "Seafood", "code": "seafood"],
                ["name" : "Serbo Croatian", "code": "serbocroatian"],
                ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                ["name" : "Singaporean", "code": "singaporean"],
                ["name" : "Slovakian", "code": "slovakian"],
                ["name" : "Soul Food", "code": "soulfood"],
                ["name" : "Soup", "code": "soup"],
                ["name" : "Southern", "code": "southern"],
                ["name" : "Spanish", "code": "spanish"],
                ["name" : "Steakhouses", "code": "steak"],
                ["name" : "Sushi Bars", "code": "sushi"],
                ["name" : "Swabian", "code": "swabian"],
                ["name" : "Swedish", "code": "swedish"],
                ["name" : "Swiss Food", "code": "swissfood"],
                ["name" : "Tabernas", "code": "tabernas"],
                ["name" : "Taiwanese", "code": "taiwanese"],
                ["name" : "Tapas Bars", "code": "tapas"],
                ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                ["name" : "Tex-Mex", "code": "tex-mex"],
                ["name" : "Thai", "code": "thai"],
                ["name" : "Traditional Norwegian", "code": "norwegian"],
                ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                ["name" : "Trattorie", "code": "trattorie"],
                ["name" : "Turkish", "code": "turkish"],
                ["name" : "Ukrainian", "code": "ukrainian"],
                ["name" : "Uzbek", "code": "uzbek"],
                ["name" : "Vegan", "code": "vegan"],
                ["name" : "Vegetarian", "code": "vegetarian"],
                ["name" : "Venison", "code": "venison"],
                ["name" : "Vietnamese", "code": "vietnamese"],
                ["name" : "Wok", "code": "wok"],
                ["name" : "Wraps", "code": "wraps"],
                ["name" : "Yugoslav", "code": "yugoslav"]]
    }
    /*
    func restaurant()->[[String:String]]{
    
        return [
            ["name":"Afghan", "code":"afghani"],
            ["name":"African","code":"african"],
            ["name":"Senegalese","code":"senegalese"],
            ["name":"South African","code":"southafrican"],
        American (New) (newamerican)
        American (Traditional) (tradamerican)
        Arabian (arabian)
        Argentine (argentine)
        Armenian (armenian)
        Asian Fusion (asianfusion)
        Australian (australian)
        Austrian (austrian)
        Bangladeshi (bangladeshi)
        Barbeque (bbq)
        Basque (basque)
        Belgian (belgian)
        Brasseries (brasseries)
        Brazilian (brazilian)
        Breakfast & Brunch (breakfast_brunch)
        British (british)
        Buffets (buffets)
        Burgers (burgers)
        Burmese (burmese)
        Cafes (cafes)
        Themed Cafes (themedcafes)
        Cafeteria (cafeteria)
        Cajun/Creole (cajun)
        Cambodian (cambodian)
        Caribbean (caribbean)
        Dominican (dominican)
        Haitian (haitian)
        Puerto Rican (puertorican)
        Trinidadian (trinidadian)
        Catalan (catalan)
        Cheesesteaks (cheesesteaks)
        Chicken Shop (chickenshop)
        Chicken Wings (chicken_wings)
        Chinese (chinese)
        Cantonese (cantonese)
        Dim Sum (dimsum)
        Hainan (hainan)
        Shanghainese (shanghainese)
        Szechuan (szechuan)
        Comfort Food (comfortfood)
        Creperies (creperies)
        Cuban (cuban)
        Czech (czech)
        Delis (delis)
        Diners (diners)
        Dinner Theater (dinnertheater)
        Ethiopian (ethiopian)
        Fast Food (hotdogs)
        Filipino (filipino)
        Fish & Chips (fishnchips)
        Fondue (fondue)
        Food Court (food_court)
        Food Stands (foodstands)
        French (french)
        Mauritius (mauritius)
        Reunion (reunion)
        Gastropubs (gastropubs)
        German (german)
        Gluten-Free (gluten_free)
        Greek (greek)
        Guamanian (guamanian)
        Halal (halal)
        Hawaiian (hawaiian)
        Himalayan/Nepalese (himalayan)
        Honduran (honduran)
        Hong Kong Style Cafe (hkcafe)
        Hot Dogs (hotdog)
        Hot Pot (hotpot)
        Hungarian (hungarian)
        Iberian (iberian)
        Indian (indpak)
        Indonesian (indonesian)
        Irish (irish)
        Italian (italian)
        Calabrian (calabrian)
        Sardinian (sardinian)
        Tuscan (tuscan)
        Japanese (japanese)
        Conveyor Belt Sushi (conveyorsushi)
        Izakaya (izakaya)
        Japanese Curry (japacurry)
        Ramen (ramen)
        Teppanyaki (teppanyaki)
        Kebab (kebab)
        Korean (korean)
        Kosher (kosher)
        Laotian (laotian)
        Latin American (latin)
        Colombian (colombian)
        Salvadoran (salvadoran)
        Venezuelan (venezuelan)
        Live/Raw Food (raw_food)
        Malaysian (malaysian)
        Mediterranean (mediterranean)
        Falafel (falafel)
        Mexican (mexican)
        Tacos (tacos)
        Middle Eastern (mideastern)
        Egyptian (egyptian)
        Lebanese (lebanese)
        Modern European (modern_european)
        Mongolian (mongolian)
        Moroccan (moroccan)
        New Mexican Cuisine (newmexican)
        Nicaraguan (nicaraguan)
        Noodles (noodles)
        Pakistani (pakistani)
        Pan Asian (panasian)
        Persian/Iranian (persian)
        Peruvian (peruvian)
        Pizza (pizza)
        Polish (polish)
        Pop-Up Restaurants (popuprestaurants)
        Portuguese (portuguese)
        Poutineries (poutineries)
        Russian (russian)
        Salad (salad)
        Sandwiches (sandwiches)
        Scandinavian (scandinavian)
        Scottish (scottish)
        Seafood (seafood)
        Singaporean (singaporean)
        Slovakian (slovakian)
        Soul Food (soulfood)
        Soup (soup)
        Southern (southern)
        Spanish (spanish)
        Sri Lankan (srilankan)
        Steakhouses (steak)
        Supper Clubs (supperclubs)
        Sushi Bars (sushi)
        Syrian (syrian)
        Taiwanese (taiwanese)
        Tapas Bars (tapas)
        Tapas/Small Plates (tapasmallplates)
        Tex-Mex (tex-mex)
        Thai (thai)
        Turkish (turkish)
        Ukrainian (ukrainian)
        Uzbek (uzbek)
        Vegan (vegan)
        Vegetarian (vegetarian)
        Vietnamese (vietnamese)
        Waffles (waffles)
        Wraps (wraps)
    
    }*/
}
