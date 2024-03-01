//
//  ViewController.swift
//  AppleMap
//
//  Created by Droadmin on 04/10/23.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController,MKMapViewDelegate {
    var pins: [MKPointAnnotation] = []
    

    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate = self
        setupPins()
        // Do any additional setup after loading the view.
    }
    func setupPins() {
        addPinToMap(coordinate: CLLocationCoordinate2D(latitude: 22.7196, longitude: 75.8577), title: "Indore", subtitle: "Madhya Pradesh, India")
        addPinToMap(coordinate: CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777), title: "Mumbai", subtitle: "Maharashtra, India")
        addPinToMap(coordinate: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090), title: "Delhi", subtitle: "India")
        addPinToMap(coordinate: CLLocationCoordinate2D(latitude: 22.3039, longitude: 70.8022), title: "Rajkot", subtitle: "Gujarat, India")
        addPinToMap(coordinate: CLLocationCoordinate2D(latitude: 17.6868, longitude: 83.2185), title: "Vizag", subtitle: "Andhra Pradesh, India")
    }


    func addPinToMap(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        pins.append(annotation)
        mapview.addAnnotation(annotation)
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let title = view.annotation?.title, let subtitle = view.annotation?.subtitle {
            let alertController = UIAlertController(title: title ?? "", message: subtitle ?? "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

