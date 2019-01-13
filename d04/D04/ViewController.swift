//
//  ViewController.swift
//  D04
//
//  Created by Duane HERVY on 1/12/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchFieldVar: UITextField!
    @IBAction func searchField(_ sender: UITextField) {
        if let apiController = myAPIController,
            let text = sender.text {
            apiController.getTweet(query: text)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchFieldVar.resignFirstResponder()
        return true
    }
    
    var myAPIController: APIController?
    var token: String? {
        didSet {
            self.myAPIController = APIController(delegate: self, token: token!)
            self.myAPIController?.getTweet(query: "ecole 42")
        }
    }
    var tweets: [Tweet] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchFieldVar.returnKeyType = .done
        getToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTweet(tweets: [Tweet]) {
        self.tweets = tweets
    }
    
    func handleError(error: NSError) {
        let alert = UIAlertController(title: "Error", message: "Cannot find your search", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetTableViewCell
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
    
    func getToken() {
        let CUSTOMER_KEY = "azgsmM9U999jIg1ndENOvPcDN"
        let CUSTOMER_SECRET = "59xB4VbOfDCJpSecCO6UQKfGdKzJcU8q9TCl13bPsu6OuqyhUn"
        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        self.token = dic["access_token"] as? String
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }


}

struct Tweet: CustomStringConvertible {
    var description: String {
        return "Name : \(name)\n Date : \(date)\n Text : \(text)\n"
    }
    let name: String
    let text: String
    let date: String
}

protocol APITwitterDelegate: class {
    func handleTweet(tweets: [Tweet])
    func handleError(error: NSError)
}
