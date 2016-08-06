//
//  ParkMapOverlay.swift
//  Park View
//
//  Created by Anna Rogers on 8/6/16.
//  Copyright © 2016 Chris Wagner. All rights reserved.
//

import UIKit
import MapKit

class ParkMapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(park: Park) {
        boundingMapRect = park.overlayBoundingMapRect
        coordinate = park.midCoordinate
    }
}
