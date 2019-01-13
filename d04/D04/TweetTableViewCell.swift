//
//  TweetTableViewCell.swift
//  D04
//
//  Created by Duane HERVY on 1/12/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            if let t = tweet {
                nameLabel.text = t.name
                dateLabel.text = t.date
                tweetLabel.text = t.text
            }
        }
    }
}
