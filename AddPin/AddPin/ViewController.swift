//
//  ViewController.swift
//  AddPin
//
//  Created by Droadmin on 05/10/23.
//

import UIKit
import MapKit
import CoreLocation
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class ViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var selectedPin:MKPlacemark? = nil

    var resultSearchController:UISearchController? = nil
    let locationSearchTable : MyTableViewController? = nil
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "MyTableViewController") as! MyTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapView
        
        locationSearchTable.handleMapSearchDelegate = self

        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        displayLocation()
        searchBar()
        
    }
    func searchBar(){
       
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    func displayLocation(){
        let location = [["title":"Rajkot","subtitle":"Gujarat,India", "latitude": 22.3039 ,"longitude": 70.8022],
                        ["title":"Indore","subtitle":"Madhya Pradesh, India", "latitude": 22.7196 ,"longitude": 75.8577],
                        ["title":"Mumbai","subtitle":"Maharashtra, India", "latitude": 19.0760,"longitude": 72.8777],
                        ["title":"Delhi","subtitle":"India", "latitude": 28.6139,"longitude": 77.2090],
                        ["title":"Vizag","subtitle":"Andhra Pradesh, India", "latitude": 17.6868 ,"longitude": 83.2185]]
        for locations in location{
            let annotion = MKPointAnnotation()
            annotion.title = locations["title"] as? String
            annotion.subtitle = locations["subtitle"] as? String
            let locationsCordinate = CLLocationCoordinate2D(latitude: locations["latitude"] as! Double, longitude: locations["longitude"] as! Double)
            annotion.coordinate = locationsCordinate
            mapView.addAnnotation(annotion)
        }
    }
    func addDiffrentImage(image: String) -> String{
        let imageMapping = [
            "Rajkot": "city",
            "Indore": "city (1)",
            "Mumbai": "india-gate",
            "Delhi": "gateway-of-india",
            "Vizag": "office-building"
        ]
        
        return imageMapping[image] ?? ""
    }
    func addDiffrentImage1(image: String) -> String{
        let imageMapping = [
            "Rajkot": "rajkot 1",
            "Indore": "indore",
            "Mumbai": "mumbi",
            "Delhi": "Delhi Small",
            "Vizag": "Vizag Small"
        ]
        return imageMapping[image] ?? ""
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .close)
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.image = UIImage(named: addDiffrentImage1(image:annotation.title ?? ""))
            annotationView?.leftCalloutAccessoryView = imageView
            
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: addDiffrentImage(image: annotation.title ?? "0"))
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            mapView.deselectAnnotation(view.annotation, animated: true)
        }
    }
    
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            print("location::\(location)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}
extension ViewController: HandleMapSearch{
    func dropPinZoomIn(placemark: MKPlacemark) {
        selectedPin = placemark
        let annotation = MKPointAnnotation()
        annotation.title = placemark.name
        if let city = placemark.locality, let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.removeAnnotations(mapView.annotations)

        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
}
