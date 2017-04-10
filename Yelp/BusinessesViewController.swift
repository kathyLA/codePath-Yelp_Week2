//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate, FilterViewControllerDelegate {
    
    var businesses: [Business]! {
        didSet {
            filterByKeyBoardInput(searchText: searchBar.text ?? "")
        }
    }
    
    var searchBar: UISearchBar!
    var searchBarFilterData: [Business]!
    var settingFilters: [String: AnyObject]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBarFilterData = []
        settingFilters = [:]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            /*if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            self.tableView.reloadData()
            */
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return searchBarFilterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell") as? BusinessCell
        cell?.business = businesses[indexPath.row]

        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as? UINavigationController
        let filterViewController = navigationController?.topViewController as? FilterViewController
        filterViewController?.settingfilters = settingFilters
        filterViewController?.delegate = self
        
    }
    
    func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject]) {
        self.settingFilters = filters
        
        let categories = filters["categories_filter"] as? [String]
        Business.searchWithTerm(term: "Restaurant", sort: nil, categories: categories, deals: nil, radius: nil) { (businesses:[Business]?, error: Error?) in
            self.businesses = businesses ?? []
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       filterByKeyBoardInput(searchText: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func filterByKeyBoardInput(searchText: String) {
        searchBarFilterData = searchText.isEmpty ? self.businesses : self.businesses.filter({ (business: Business) -> Bool in
            return (business.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil)
            //TODO : Also filter by address and filter other keyword
        })
        tableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
