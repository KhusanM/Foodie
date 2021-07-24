//
//  BranchesMapVC.swift
//  Foodie
//
//  Created by Oybek Iskandarov on 7/6/21.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SDWebImage

class BranchesMapVC: UIViewController {

    var evos : MKPointAnnotation!
    var kfc : MKPointAnnotation!
    var belissimo : MKPointAnnotation!
    var blackStar : MKPointAnnotation!
    
    private var pins : [MKPointAnnotation] = []
    var locationManager: CLLocationManager!
    var isGettingCurrentLocation: Bool = false
    
    @IBOutlet weak var map: MKMapView!
    
    var geoDM: [GeoDM] = []
    var photoArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        map.delegate = self
        getGeo(name: "gio")
    }
    
    
    func setupGeo(){
        evos = MKPointAnnotation()
        evos.title = geoDM[0].name
        evos.coordinate = CLLocationCoordinate2D(latitude: geoDM[0].lat, longitude: geoDM[0].long)
        kfc = MKPointAnnotation()
        kfc.title = geoDM[1].name
        kfc.coordinate = CLLocationCoordinate2D(latitude: geoDM[1].lat, longitude: geoDM[1].long)
        belissimo = MKPointAnnotation()
        belissimo.title = geoDM[2].name
        belissimo.coordinate = CLLocationCoordinate2D(latitude: geoDM[2].lat, longitude: geoDM[2].long)
        blackStar = MKPointAnnotation()
        blackStar.title = geoDM[3].name
        blackStar.coordinate = CLLocationCoordinate2D(latitude: geoDM[3].lat, longitude: geoDM[3].long)
        map.addAnnotation(evos)
        map.addAnnotation(kfc)
        map.addAnnotation(belissimo)
        map.addAnnotation(blackStar)
    }
    
    private func getGeo(name: String){
        let header : HTTPHeaders = ["Authorization" : Cache.getUserToken()]
        AF.request(base_URL+"/api/\(name)", method: .get, encoding: URLEncoding.queryString, headers: header).responseJSON { [self] response in
            let statusCode = response.response?.statusCode
            switch statusCode{
            case 200:
                if let d = response.data{
                    let jsonData = JSON(d)
                    let data = jsonData["data"]
                    
                    
                    for i in data.enumerated(){
                        //photoArr.removeAll()
                        for j in data[i.offset]["photo"].arrayValue{
                            photoArr.append(j.stringValue)
                        }
                        let d = GeoDM(_id: data[i.offset]["id"].stringValue, name: data[i.offset]["name"].stringValue, photo: photoArr, lat: data[i.offset]["lat"].doubleValue, long: data[i.offset]["long"].doubleValue)
                        
                        geoDM.append(d)
                    }
                    for i in self.geoDM {
                        let pin = MKPointAnnotation()
                        pin.coordinate = CLLocationCoordinate2D(latitude: i.lat, longitude: i.long)
                        pin.title = i.name
                        self.pins.append(pin)
                        self.map.addAnnotation(pin)
                    }
                    
                    map.delegate = self
                    //setupGeo()
                }
            case 401:
                print(response.error?.errorDescription)
            case 404:
                print(response.error?.errorDescription)
            default:
                break
            }
        }
    }

    @IBAction func gpsButton(_ sender: Any) {
        isGettingCurrentLocation = true
        locationManager.startUpdatingLocation()
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
        
        for i in pins.enumerated(){
            if annotation.title == i.element.title{
                

                if annotationView == nil {
                    annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "a")
                    
                    annotationView?.image =  #imageLiteral(resourceName: "circleRed")
                    let imgView = UIImageView()
                    imgView.sd_setImage(with: URL(string: base_URL+geoDM[i.offset].photo.first!),placeholderImage:  #imageLiteral(resourceName: "ellip"))

                    annotationView?.rightCalloutAccessoryView = UIImageView(image :  #imageLiteral(resourceName: "image2"))
                    annotationView!.canShowCallout = true
                }
                else {
                    annotationView!.annotation = annotation
                }
            }
        }
        return annotationView
        
    }
}

extension BranchesMapVC{
    @objc func mapBtnTapped(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: -250, width: 200, height: 200))
                
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.view.addSubview(imageView)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension BranchesMapVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isGettingCurrentLocation{
            let coordinates = locations[0].coordinate
            map.camera.centerCoordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
            manager.stopUpdatingLocation()
            isGettingCurrentLocation = false
        }
    }
}

