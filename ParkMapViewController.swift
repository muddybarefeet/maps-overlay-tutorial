//
//  ParkMapViewController.swift
//  Park View
//
//  Created by Niv Yahel on 2014-11-09.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

import UIKit
import MapKit

enum MapType: Int {
  case Standard = 0
  case Hybrid
  case Satellite
}

class ParkMapViewController: UIViewController, MKMapViewDelegate {
  
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var mapView: MKMapView!

    var selectedOptions = [MapOptionsType]()
    var park = Park(filename: "MagicMountain")

    override func viewDidLoad() {
        super.viewDidLoad()
        let latDelta = park.overlayTopLeftCoordinate.latitude - park.overlayBottomRightCoordinate.latitude
        // think of a span as a tv size, measure from one corner to another
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        let region = MKCoordinateRegionMake(park.midCoordinate, span)
        mapView.region = region
        addOverlay()
    }
    
    func addOverlay() {
        let overlay = ParkMapOverlay(park: park)
        mapView.addOverlay(overlay)
    }
    
    func loadSelectedOptions() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        for option in selectedOptions {
            switch (option) {
            case .MapOverlay:
                addOverlay()
            default:
                break;
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let optionsViewController = segue.destinationViewController as! MapOptionsViewController
        optionsViewController.selectedOptions = selectedOptions
    }

    @IBAction func closeOptions(exitSegue: UIStoryboardSegue) {
        let optionsViewController = exitSegue.sourceViewController as! MapOptionsViewController
        selectedOptions = optionsViewController.selectedOptions
        self.loadSelectedOptions()
    }

    @IBAction func mapTypeChanged(sender: AnyObject) {
    // To be implemented
        let mapType = MapType(rawValue: mapTypeSegmentedControl.selectedSegmentIndex)
        switch (mapType!) {
        case .Standard:
            mapView.mapType = MKMapType.Standard
        case .Hybrid:
            mapView.mapType = MKMapType.Hybrid
        case .Satellite:
            mapView.mapType = MKMapType.Satellite
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayView: MKOverlayRenderer?
        if overlay is ParkMapOverlay {
            let magicMountainImage = UIImage(named: "overlay_park")
            overlayView = ParkMapOverlayView(overlay: overlay, overlayImage: magicMountainImage!)
            return overlayView!
        }
        return MKOverlayRenderer()
    }
}
