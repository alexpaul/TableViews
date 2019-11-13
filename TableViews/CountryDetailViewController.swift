//
//  CountryDetailViewController.swift
//  TableViews
//
//  Created by Alex Paul on 11/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  
  // expected data is a Country object
  // this property gets set in the prepareForSegue method
  // from the ContinentsViewController
  var country: Country? // we need to use a default value here, in this case it is optional which defaults to nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  func updateUI() {
    guard let country = country else {
      fatalError("Could not setup UI, country is not set, verify prepareForSegue from source segue")
    }
    imageView.image = UIImage(named: "\(country.fullImageName)")
    // set title of navigation bar
    title = country.name
  }
}
