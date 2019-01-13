//
//  ViewController.swift
//  D03
//
//  Created by Duane HERVY on 1/11/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToImage" {
            if let dest = segue.destination as? SecondViewController {
                if let send = sender as? CollectionViewCell {
                    dest.image = send.imageCell.image
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.imagesURL.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",
                                                      for: indexPath) as! CollectionViewCell

        cell.imageUrl = Data.imagesURL[indexPath.row]
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: cell.imageCell.frame.size.width, height: cell.imageCell.frame.size.height)
        activityIndicator.startAnimating()
        displayActivityndicator(state: true)
        if cell.imageCell.image == nil{
            cell.imageCell.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: Data.imagesURL[indexPath.row])! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Cannot access to \(Data.imagesURL[indexPath.row])", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                displayActivityndicator(state: false)
                return
            }
            
            let qos = DispatchQoS.background.qosClass
            let queue = DispatchQueue.global(qos: qos)
            
            queue.async { () -> Void in
                let image = UIImage(data: data!)
                DispatchQueue.main.async { () -> Void in
                    activityIndicator.removeFromSuperview()
                    cell.imageCell.image = image
                    displayActivityndicator(state: false)
                }
            }
            
        }).resume()
        
        return cell
    }

    
    



}

var numberImageInProgress = 0

func displayActivityndicator(state: Bool) {
    numberImageInProgress = state ? numberImageInProgress + 1 : numberImageInProgress - 1
    UIApplication.shared.isNetworkActivityIndicatorVisible = numberImageInProgress > 0 ? true : false
}

extension UIImageView {
    public func imageFromURL(urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        displayActivityndicator(state: true)
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            
            let qos = DispatchQoS.background.qosClass
            let queue = DispatchQueue.global(qos: qos)
            
            queue.async { () -> Void in
                let image = UIImage(data: data!)
                DispatchQueue.main.async { () -> Void in
                    activityIndicator.removeFromSuperview()
                    self.image = image
                    displayActivityndicator(state: false)
                }
            }
            
        }).resume()
    }
}
