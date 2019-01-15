//
//  ListViewController.swift
//  D02
//
//  Created by Duane hervy on 14/01/2019.
//  Copyright © 2019 Duane HERVY. All rights reserved.ListViewController
//

import UIKit

struct Place {
    var ListName: String
    var title: String
    var subtitle: String
    var latitude: Double
    var longitude: Double
    var pinColor: UIColor
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let places = [
        Place(ListName: "Ecole", title: "Ecole 42", subtitle: "Mon école", latitude: 48.896628, longitude: 2.318512, pinColor: .blue),
        Place(ListName: "Chez mes parents", title: "La turballe", subtitle: "12 rue du pinker", latitude: 47.349951, longitude: -2.509243, pinColor: .green),
        Place(ListName: "Chez moi", title: "Saint-Cloud", subtitle: "7 rue armengaud", latitude: 48.846767, longitude: 2.216472, pinColor: .red),
    ]
    
    var delegate: MapViewController?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "List", image: UIImage(named: "iconList"), tag: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
        
        cell?.textLabel?.text = places[indexPath.row].ListName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
        self.delegate?.place = places[indexPath.row]
        self.tabBarController?.selectedIndex = 1;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self.tabBarController?.viewControllers?[1] as? MapViewController
        self.delegate?.place = places[0]
    }
}
