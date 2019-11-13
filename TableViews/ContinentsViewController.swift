//
//  ContinentsViewController.swift
//  TableViews
//
//  Created by Alex Paul on 11/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

/*
 data comes from our Country struct
 
 1. connect the tableview using an IBOutlet
 2. set the view controller as the data source for the table view in viewDidLoad
 3. use an extension on the ContinentsViewController and conform to UITableViewDataSource
 4. implement required methods
*/

class ContinentsViewController: UIViewController {
  
  // 1. connect the tableview using an IBOutlet
  @IBOutlet weak var tableView: UITableView!
  
  private var continents = [[Country]]() {
    didSet { // property observer, gets called when continents is changed or set
      tableView.reloadData() // reloads ALL the contents of the table view
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //  2. set the view controller as the data source for the table view in viewDidLoad
    tableView.dataSource = self
    
    loadData()
  }
  
  // helper method
  func loadData() {
    var sections = [[Country]]()
    for section in Country.getSections() {
      sections.append(section.sorted {$0.name < $1.name } ) // sort countries in each section in ascending order
    }
    continents = sections
    // didSet will get called on continents and table view will be reloaded
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("prepareForSegue")
    
    // here is where we will pass data from the ContinentsViewController to the CountryDetailViewController
    
    // we will pass the selected country the CountryDetailViewController
    
    // segue has a .source and a .destination property
    
    guard let countryDVC = segue.destination as? CountryDetailViewController,
      let indexPath = tableView.indexPathForSelectedRow else {
      fatalError("Couldn't segue due to missing destination, indexPath")
    }
     
    // set country on countryDVC
    countryDVC.country = continents[indexPath.section][indexPath.row]
    
  }
}

//  3. use an extension on the ContinentsViewController and conform to UITableViewDataSource
extension ContinentsViewController: UITableViewDataSource {
  //  4. implement required methods
  
  // REQUIRED METHOD 1
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // the data for this table view is an array of arrays [[Country]]
    // no longer can we simply return continents.count
    // this would return 5 in our case, since we have 5 sections (continents) currently
    
    // we need to return the section's count
    // [section].count on the array of arrays
    return continents[section].count
  }
  
  // REQUIRED METHOD 2
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // step 1: get a cell using dequeueReusableCell()
    let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
    
    // step 2: we need to get the current object at the current indexPath
    let country = continents[indexPath.section][indexPath.row]
    
    // step 3: configure cell
    cell.textLabel?.text = country.name
    cell.detailTextLabel?.text = country.description
    //cell.detailTextLabel?.numberOfLines = 0
    cell.imageView?.image = UIImage(named: "\(country.thumbnailImageName)")
    
    // step 4: return cell
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return continents.count // 5
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return continents[section].first?.continent
  }
}
