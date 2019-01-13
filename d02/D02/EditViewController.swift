//
//  EditViewController.swift
//  D02
//
//  Created by Duane HERVY on 1/10/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var dateDeath: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneFunc))
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.title = "Nouveau"
        dateDeath.minimumDate = Date()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            if nameField.text?.count != 0 {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "fr_FR")
                dateFormatter.dateFormat = "d MMM yyyy HH:mm"
                let date = dateFormatter.string(from: dateDeath.date)
                if descField.text?.count != 0 {
                    Data.list.append((nameField.text!, descField.text!, date))
                } else {
                    Data.list.append((nameField.text!, "Peu import", date))
                }
            }
        }
    }

    @objc func doneFunc() {
        print("Nom : \(nameField.text!)")
        print("Description : \(descField.text!)")
        performSegue(withIdentifier: "doneSegue", sender: self)
    }
}

