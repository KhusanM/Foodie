//
//  BranchesMapVC.swift
//  Foodie
//
//  Created by Oybek Iskandarov on 7/6/21.
//

import UIKit
import MapKit
import CoreLocation

class BranchesMapVC: UIViewController {

    var pin1 : MKPointAnnotation!
    var pin2 : MKPointAnnotation!
    var pin3 : MKPointAnnotation!
    var pin4 : MKPointAnnotation!
    var pin5 : MKPointAnnotation!
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        map.delegate = self
        
        pin1 = MKPointAnnotation()
        pin1.title = "Fillial 1"
        pin1.coordinate = CLLocationCoordinate2D(latitude: 41.33036201638839, longitude: 69.23378895610504)
        pin2 = MKPointAnnotation()
        pin2.title = "Fillial 2"
        pin2.coordinate = CLLocationCoordinate2D(latitude: 41.32511405175779, longitude: 69.22522195955672)
        pin3 = MKPointAnnotation()
        pin3.title = "Fillial 3"
        pin3.coordinate = CLLocationCoordinate2D(latitude: 41.294675421868206, longitude: 69.24071194712015)
        pin4 = MKPointAnnotation()
        pin4.title = "Fillial 4"
        pin4.coordinate = CLLocationCoordinate2D(latitude: 41.274742939074194, longitude: 69.24663225296827)
        pin5 = MKPointAnnotation()
        pin5.title = "Fillial 5"
        pin5.coordinate = CLLocationCoordinate2D(latitude: 41.328962038200444, longitude: 69.31092895209731)
  
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func gpsButton(_ sender: Any) {
        
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}


extension BranchesMapVC : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
                return nil
            }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "a")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "a")
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        switch annotation.title {
        case pin1.title: annotationView?.image = UIImage(named: "mini")
        case pin2.title: annotationView?.image = UIImage(named: "mini")
        case pin3.title: annotationView?.image = UIImage(named: "mini")
        case pin4.title: annotationView?.image = UIImage(named: "mini")
        case pin5.title: annotationView?.image = UIImage(named: "mini")
            
            
        default:
            break
        }
        
        return annotationView
        
    }
}
