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
    var settingFilters: [String: AnyObject] = [String: AnyObject]()
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
        
        
        
       
        if settingFilters.count == 0 {
            settingFilters["deal_filter"] = false as AnyObject?
            settingFilters["distance_filter_index"] = 0 as AnyObject?
            settingFilters["sort_filter"] = 0 as AnyObject?
            settingFilters["sort_filter_index"] = 0 as AnyObject?
            settingFilters["distance_filter"] = 0.0 as AnyObject?
        }
        updateFilter(filters: settingFilters)
        
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
        updateFilter(filters: filters)
    }
    
    func updateFilter(filters: [String: AnyObject]) {
            let deals = filters["deal_filter"]  as? Bool
            let sort = filters["sort_filter"] as? Int
            let categories = filters["categories_filter"] as? [String: String] ?? [String: String]()
        
            let selectedCategories = categories.map {$0.value}
            var distance = filters["distance_filter"] as? Double ?? 0
            distance = distance * 1609.344
            Business.searchWithTerm(term: "Restaurant", sort: YelpSortMode(rawValue: sort!) , categories: selectedCategories, deals: deals, radius: distance) { (businesses:[Business]?, error: Error?) in
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
