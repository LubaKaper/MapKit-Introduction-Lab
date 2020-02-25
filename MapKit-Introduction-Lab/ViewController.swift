//
//  ViewController.swift
//  MapKit-Introduction-Lab
//
//  Created by Liubov Kaper  on 2/25/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    private let locationSession = CoreLocationSession()
    
    private var isShowingNewAnnotations = false
    
    private var annotations = [MKPointAnnotation]()
    
    //var location: SchoolData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        mapView.delegate = self
        loadMap()
       
    }
    
    private func loadMap() {
        let annotations = makeAnnotations()
        mapView.addAnnotations(annotations)
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for location in SchoolData.getSschools() {
            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!)
            annotation.title = location.school_name
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        isShowingNewAnnotations = true
        self.annotations = annotations
        return annotations
    }


}
extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .black
            annotationView?.markerTintColor = .systemBlue
            //annotationView?.glyphText = location.school_name
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingNewAnnotations {
        mapView.showAnnotations(annotations, animated: false)
        }
        isShowingNewAnnotations = false
    }
    
}
