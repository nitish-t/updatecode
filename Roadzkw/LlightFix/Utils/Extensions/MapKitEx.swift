/*************************  *************************/
//
//  MapKitEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    private struct storeProperty {
        static var isShowAllAnnotiations: Bool = false
    }
    var isShowAllAnnotiations: Bool {
        get {
            guard let isShowAllAnnotiations = objc_getAssociatedObject(self, &storeProperty.isShowAllAnnotiations) as? Bool else {
                return false
            }
            return isShowAllAnnotiations
        }
        set {
            objc_setAssociatedObject(self, &storeProperty.isShowAllAnnotiations, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D) {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.coordinate = coordinate
        self.addAnnotation(pointAnnotation)
        let allAnnotations = self.annotations
        self.showAnnotations(allAnnotations, animated: true)
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D, title: String) {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.title = title
        pointAnnotation.coordinate = coordinate
        self.addAnnotation(pointAnnotation)
        let allAnnotations = self.annotations
        self.showAnnotations(allAnnotations, animated: true)
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D, image: String) {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.image = image
        self.addAnnotation(pointAnnotation)
        let allAnnotations = self.annotations
        self.showAnnotations(allAnnotations, animated: true)
    }
    
    
    func addMarker(coordinate: CLLocationCoordinate2D, image: String, title: String) {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.title = title
        pointAnnotation.coordinate = coordinate
        pointAnnotation.image = image
        self.addAnnotation(pointAnnotation)
        let allAnnotations = self.annotations
        self.showAnnotations(allAnnotations, animated: true)
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D, image: String, object: Any) {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.object = object
        pointAnnotation.image = image
        self.addAnnotation(pointAnnotation)
        let allAnnotations = self.annotations
        self.showAnnotations(allAnnotations, animated: true)
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D, image: String, object: Any, title: String) {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.title = title
        pointAnnotation.coordinate = coordinate
        pointAnnotation.object = object
        pointAnnotation.image = image
        self.addAnnotation(pointAnnotation)
        if self.isShowAllAnnotiations {
            let allAnnotations = self.annotations
            self.showAnnotations(allAnnotations, animated: true)
        }
    }
    
    func mapViewOwnDelegate(_ mapView: MKMapView, viewFor annotation: MKAnnotation, defualtMarkerImage: String, ownConfigtation: @escaping ((MKAnnotationView, CustomPointAnnotation) -> (Void))) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        guard let  annotation =  annotation as? CustomPointAnnotation else { return nil}
        let identifier = "annotationView"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        if let annotationView = annotationView { // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = annotation.image != nil ? "\(annotation.image ?? defualtMarkerImage)".image_ : nil
            ownConfigtation(annotationView, annotation)
        }
        return (annotationView?.image != nil) ? annotationView :  nil
    }
}

class CustomPointAnnotation: MKPointAnnotation {
    var object: Any?
    var image: String?
}
