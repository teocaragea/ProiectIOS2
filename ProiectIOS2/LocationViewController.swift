//
//  LocationViewController.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 22.03.2022.
//
import MapKit
import CoreLocation
import UIKit

class LocationViewController: UIViewController, MKMapViewDelegate {
    let coordinate = CLLocationCoordinate2D(latitude: 44.43464928, longitude: 26.100669973)
    let map = MKMapView()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Our location"
        
        view.addSubview(map)
        map.frame = view.bounds
        
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
       
        map.delegate = self
        addCustomPin()
        
    }
    private func addCustomPin(){
        let pin = MKPointAnnotation()
        pin.title = "Food Here"
        pin.coordinate = coordinate
        pin.subtitle = "Come and eat here"
        map.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "fork")
        
        return annotationView
    }
    

}
