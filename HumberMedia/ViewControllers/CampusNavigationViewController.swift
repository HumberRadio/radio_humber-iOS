//
//  CampusNavigationViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/4/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import GoogleMaps

class CampusNavigationViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    
    var campus:Campus = Campus()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //google maps api
        GMSServices.provideAPIKey("AIzaSyBm_sU8GO6mrJwlee5P5KsdrchRTGsBQ5k")
        var camera = GMSCameraPosition.camera(withLatitude: 43.7344449, longitude: -79.612143, zoom: 16)
        if !campus.campusName.isEmpty
        {
            camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(campus.latitute), longitude: CLLocationDegrees(campus.longitute), zoom: 16.5)
        }
        
       
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.animate(to: camera)
//        let mapView1 = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
//        self.mapView = mapView1
        
        self.mapView.isIndoorEnabled = true
        self.mapView.isMyLocationEnabled = true
        self.mapView.isUserInteractionEnabled = false
//        self.mapView.
//        view = self.mapView
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // Creates a marker in the center of the map.
        //let marker = GMSMarker()
        //marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //marker.title = "Humber North Campus"
        //marker.snippet = "Toronto"
        //marker.map = mapView
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //Location Manager delegates
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        //let camera = GMSCameraPosition.cameraWithLatitude((location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        //let camera
        
        //self.mapView?.animateToCameraPosition(camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }

}
