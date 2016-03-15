//
//  MapViewLocationController.swift
//  WorldTrotter
//
//  Created by Roman Ustiantcev on 23/02/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewUserLocationController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var manager: CLLocationManager!
    var myLocations: [CLLocation] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // before that we need to change our info.plist file and add 
        // NSLocationAlwaysUsageDescription 
        // and
        // NSLocationWhenInUseUsageDescription
        
        // setup our location manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        // setup our map view after loading an app
        theMap.delegate = self
        theMap.mapType = MKMapType.Satellite
        theMap.showsUserLocation = true
        
        // setting locations
        let tyumenLocation = CLLocationCoordinate2DMake(57.1522200	, 65.5272200)
        
        // setting/fropping a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = tyumenLocation
        dropPin.title = "Tyumen location"
        
        segmentControl.backgroundColor = UIColor .whiteColor().colorWithAlphaComponent(0.5)
        segmentControl.selectedSegmentIndex = 0
        
    }
    
    @IBAction func mapChangeControl(sender: AnyObject) {
        // segment control
        switch segmentControl.selectedSegmentIndex{
        
        case 0:
            theMap.mapType = .Standard
        case 1:
            theMap.mapType = .Hybrid
        case 2:
            theMap.mapType = .Satellite
        default:
            break
        }
        
        
    }
    @IBAction func findUser(sender: AnyObject) {
        
            // find user and then follow his direction
            let spanX = 0.007
            let spanY = 0.007
            
            let newRegion = MKCoordinateRegion(center: theMap.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: spanX, longitudeDelta: spanY))
            theMap.setRegion(newRegion, animated: true)
            
            if (myLocations.count > 1){
                
                let sourceIndex = myLocations.count - 1
                let destinationIndex = myLocations.count - 2
                
                let c1 = myLocations[sourceIndex].coordinate
                let c2 = myLocations[destinationIndex].coordinate
                
                var a = [c1, c2]
                
                let polyline = MKPolyline(coordinates: &a, count: a.count)
                
                theMap.addOverlay(polyline)
            }

        print("button clicked")
        
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            
            // setup a pointer to the user
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
    
    
}