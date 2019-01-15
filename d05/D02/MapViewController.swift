//
//  MapViewController.swift
//  D02
//
//  Created by Duane hervy on 14/01/2019.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit
import MapKit

class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func changeMode(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            mapView.mapType = MKMapType.standard;
        case 1:
            mapView.mapType = MKMapType.satellite;
        case 2:
            mapView.mapType = MKMapType.hybrid;
        default:
            break
        }
    }
    
    var delegate: ListViewController?
    
    var place: Place? {
        didSet {
            if let p = place {
                print(p)
                let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(p.latitude, p.longitude)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                mapView?.setRegion(region, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
        }
        annotationView?.canShowCallout = true
        return annotationView
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "iconMap"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self.tabBarController?.viewControllers?[0] as? ListViewController
        
        if let p = place {
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(p.latitude, p.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapView?.setRegion(region, animated: true)
        }
        
        for pla in self.delegate?.places ?? [] {
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(pla.latitude, pla.longitude)
            let annotation = MyPointAnnotation()
            annotation.coordinate = location
            annotation.title = pla.title
            annotation.subtitle = pla.subtitle
            annotation.pinTintColor = pla.pinColor
            mapView.addAnnotation(annotation)
        }
    }

}

