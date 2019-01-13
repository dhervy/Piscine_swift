//
//  deathTableViewCell.swift
//  D02
//
//  Created by Duane HERVY on 1/10/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class deathTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    var death : (String, String, String)? {
        didSet {
            if let d = death {
                nameLabel?.text = d.0
                reasonLabel?.text = d.1
                dateLabel?.text = d.2
            }
        }
    }
}
