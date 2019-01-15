//
//  ViewController.swift
//  D02
//
//  Created by Duane HERVY on 1/10/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell") as! deathTableViewCell
        cell.death = Data.list[indexPath.row]
        return cell
    }
    
    


}

struct Data {
    static var list: [(String, String, String)] = [
        ("Thomas", "À trop codé", "16 janv. 2017 21:26"),
        ("Marvin", "Est tombé de ça hauteur", "26 juil. 2018 21:26"),
        ("Duane", "Les premiers jours sans nourriture ne sont pas, vous vous en doutez, les plus difficiles et les gargouillis finissent même par disparaître. Au bout de quelques semaines, si vous continuez à boire un peu d'eau, les vertiges vous prennent, votre coeur ralentit et vous êtes terriblement fatigué. Votre ventre et vos muscles sont douloureux, vous avez froid, mal à la tête et vous ne dormez plus. Et en plus vous avez le hoquet. Passées les 4 semaines ça se corse sévèrement puisqu'arrivent les vomissements, la jaunisse, mais aussi la surdité et la cécité. Vous saignez des yeux, des gencives et votre cerveau subit des lésions irréversibles. Passés les 40 jours de jeûne, vous oscillez entre euphorie et somnolence avant de tomber dans le coma et de mourir.", "10 janv. 2019 15:26"),
    ]
}
