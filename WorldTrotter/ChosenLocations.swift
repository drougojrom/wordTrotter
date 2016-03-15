//
//  ChosenLocations.swift
//  WorldTrotter
//
//  Created by Roman Ustiantcev on 24/02/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import MapKit
import UIKit

class ChosenLocations: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String = "Favorite Location", coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
    
}
