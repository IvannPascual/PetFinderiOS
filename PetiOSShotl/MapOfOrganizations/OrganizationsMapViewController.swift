//
//  OrganizationsMapViewController.swift
//  PetiOSShotl
//
//  Created by IVAN on 22/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class OrganizationsMapViewController: UIViewController {
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       let organitzations =  UserDataManager.shared.retrieveOrgranitzations()
       let leftMargin:CGFloat = 0
       let topMargin:CGFloat = 0
       let mapWidth:CGFloat = view.frame.size.width
       let mapHeight:CGFloat = view.frame.size.height
       
       mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
       
       mapView.mapType = MKMapType.standard
       mapView.isZoomEnabled = true
       mapView.isScrollEnabled = true
       
       // Or, if needed, we can position map in the center of the view
       mapView.center = view.center
       setActualCoordinate()
       showPointWithPostalCode()
        //showPoints()
        showNearOrganitzations()
       view.addSubview(mapView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           
    }
    
    func setActualCoordinate() {
        let location = CLLocationCoordinate2D(latitude: 51.50007773,longitude: -0.1246402)
        mapView.setCenter(location, animated: true)
    }
    func showPoint() {
        let annotation = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: 51.50007773,
        longitude: -0.1246402)
        annotation.coordinate = location
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        mapView.addAnnotation(annotation)
    }
    
    func showPointWithPostalCode() {
        let address = "1 Infinite Loop, Cupertino, CA 95014"
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            let location = placemarks?.first?.location
            let annotations = MKPointAnnotation()
            guard let coordinate = location?.coordinate else {
                return
            }
            annotations.coordinate = coordinate
            self.mapView.addAnnotation(annotations)
        }
    }
    
    func showNearOrganitzations() {
       let organitzationsVM = UserDataManager.shared.listOfOrganitzations
        for organitzation in organitzationsVM.organitzations {
            let address = organitzation.address.address1
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                       let location = placemarks?.first?.location
                       let annotations = MKPointAnnotation()
                       guard let coordinate = location?.coordinate else {
                           return
                       }
                       annotations.coordinate = coordinate
                       self.mapView.addAnnotation(annotations)
            }
        }
    }

}
    


