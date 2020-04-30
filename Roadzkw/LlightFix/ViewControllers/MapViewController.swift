//
//  MapViewController.swift
//  LlightFix
//
//  Created by  on 9/4/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import MapKit
import SwiftLocation
import CoreLocation

class MapViewController: BaseViewController, CLLocationManagerDelegate
 {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    let newPin = MKPointAnnotation()

    var package_id : NSNumber?
    var selectedService : TServiceObject?
    var selectedCar : TCarObject?

    var selectedLocation : CLLocationCoordinate2D?
    
    var isConfirm : Bool = false
    var locationName : String?
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        
        // Do any additional setup after loading the view.
        if isConfirm == true {
            self.mapView.isUserInteractionEnabled = false
            self.btnConfirm.localized = "HomeVC.btnOrder.title"
            self.btnConfirm.backgroundColor = UIColor(named: "#009BA2")
            self.btnConfirm.layer.cornerRadius = 23.5 
            self.btnConfirm.clipsToBounds = true
            self.btnConfirm.setBackgroundImage(nil, for: .normal)
            self.lblLocationName.text = self.locationName
            if let locValue = self.selectedLocation {
                self.mapView.setCenter(locValue, animated: false)
                     mapView.mapType = MKMapType.standard
                     let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
                     let region = MKCoordinateRegion(center: locValue, span: span)
                     mapView.setRegion(region, animated: false)
                     
                     let userCoordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
                     let eyeCoordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
                     let camera = MKMapCamera(lookingAtCenter: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 1500.0)
                     self.selectedLocation = userCoordinate
                     mapView.setCamera(camera, animated: false)
                     mapView.isZoomEnabled = true
                     mapView.showsUserLocation = true
            }
        }
        else {
            let locationManager = CLLocationManager()

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest

            // Check for Location Services
            if (CLLocationManager.locationServicesEnabled()) {
                locationManager.requestAlwaysAuthorization()
                locationManager.requestWhenInUseAuthorization()
            }

            //Zoom to user location
            if let userLocation = locationManager.location?.coordinate {
                let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapView.setRegion(viewRegion, animated: false)
                mapView.showsUserLocation = true

            }

            self.locationManager = locationManager

            DispatchQueue.main.async {
                self.locationManager.startUpdatingLocation()
            }

        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toServiceStatusVC"{
            let vc = segue.destination as! RequestServiceStatusViewController
            vc.resultOfService = (sender as? Bool) ?? true
        }
        else if segue.identifier == "toGuestServiceStatusVC"{
            let vc = segue.destination as! ServiceStatusViewController
            vc.resultOfService = (sender as? Bool) ?? true

        }
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        if self.selectedLocation == nil {
            self.showPopAlert(title: "Error", message: "YouNeedToSelectLocationFirst")
            return
        }
        if isConfirm == true {
            if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
                self.performSegueWithCheck(withIdentifier: "toGuestServiceStatusVC", sender: true)
                return
            }
            let request = SubscriptionsRequest(.make)
            request.car_id = self.selectedCar?.pk_i_id
            request.package_id = self.package_id
            request.latitude = NSNumber(value:self.selectedLocation?.latitude ?? 0.0)
            request.longitude = NSNumber(value:self.selectedLocation?.longitude ?? 0.0)
            request.service_id = self.selectedService?.pk_i_id
            NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                self.performSegueWithCheck(withIdentifier: "toServiceStatusVC", sender: responce.status?.success)
            }
        }else{
            let vc = MapViewController.initiateInstance() as! MapViewController
            vc.package_id = self.package_id
            vc.selectedService = self.selectedService
            vc.selectedCar = self.selectedCar
            vc.selectedLocation = self.selectedLocation
            vc.isConfirm = true
            vc.locationName = self.lblLocationName.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.checkLocation()
    }
    func checkLocation(){
        if isConfirm == true {
            return
        }
        Locator.location(fromCoordinates: self.mapView.centerCoordinate, onSuccess: { (plases) -> (Void) in
            if let place = plases.first?.placemark {
                let pin = UIImage(named: "ic_location_point")

                self.lblLocationName.text = ReversedGeoLocation(with: place).formattedAddress
                self.selectedLocation = self.mapView.centerCoordinate
                self.mapView.removeAnnotation(self.newPin)
                self.newPin.coordinate = self.mapView.centerCoordinate
            //    self.mapView.addAnnotation(self.newPin)

            }else{
                self.lblLocationName.text = ""
                self.selectedLocation = nil
            }
        }) { (error) -> (Void) in
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        mapView.mapType = MKMapType.standard
        let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
   //     let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let userCoordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let eyeCoordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let camera = MKMapCamera(lookingAtCenter: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 1500.0)
        self.selectedLocation = userCoordinate
        mapView.setCamera(camera, animated: true)
        mapView.isZoomEnabled = true


        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation()
    }

}


struct ReversedGeoLocation {
    let name: String            // eg. Apple Inc.
    let streetName: String      // eg. Infinite Loop
    let streetNumber: String    // eg. 1
    let city: String            // eg. Cupertino
    let state: String           // eg. CA
    let zipCode: String         // eg. 95014
    let country: String         // eg. United States
    let isoCountryCode: String  // eg. US
    let areasOfInterest: String  // eg.
    
    var formattedAddress: String {
        var str = ""
        if areasOfInterest.count > 0 {
            str = str + areasOfInterest + "\n"
        }
        if name.count > 0 {
            str = str + name + "\n"
        }else if streetNumber.count > 0 && streetName.count > 0 {
            str = str + "\(streetNumber) \(streetName)" + "\n"
        }
        if city.count > 0 && state.count > 0 && zipCode.count > 0 {
            str = str + "\(city), \(state) \(zipCode)" + "\n"
        }
        if country.count > 0 {
            str = str + country
        }
        return str
        //        """
        //        \(name),
        //        \(streetNumber) \(streetName),
        //        \(city), \(state) \(zipCode)
        //        \(country)
        //        """
    }
    
    // Handle optionals as needed
    init(with placemark: CLPlacemark) {
        self.name            = placemark.name ?? ""
        self.streetName      = placemark.thoroughfare ?? ""
        self.streetNumber    = placemark.subThoroughfare ?? ""
        self.city            = placemark.locality ?? ""
        self.state           = placemark.administrativeArea ?? ""
        self.zipCode         = placemark.postalCode ?? ""
        self.country         = placemark.country ?? ""
        self.isoCountryCode  = placemark.isoCountryCode ?? ""
        self.areasOfInterest = placemark.areasOfInterest?.first ?? ""
    }
}
