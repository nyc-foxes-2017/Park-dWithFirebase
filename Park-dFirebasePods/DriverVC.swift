//
//  DriverVC.swift
//  Park-dFirebasePods
//
//  Created by Sophia Pignatelli on 4/8/17.
//  Copyright © 2017 Sophia Pignatelli. All rights reserved.
//

import UIKit
import MapKit

class DriverVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    
    private var locationManager = CLLocationManager();
    private var userLocation: CLLocationCoordinate2D?;
//    private var riderLocation: CLLocationCoordinate2D;
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocationManage()

        // Do any additional setup after loading the view.
    }
    
    private func initializeLocationManage() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // if we have the coordinate from the manager
        if let location = locationManager.location?.coordinate{
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
            
            myMap.setRegion(region, animated: true);
            
            let annotation = MKPointAnnotation();
            annotation.coordinate = userLocation!;
            annotation.title = "Your Location"
            myMap.addAnnotation(annotation)
            
            
        }
    }

    @IBAction func checkIn(_ sender: Any) {
    }

    @IBAction func taken(_ sender: Any) {
    }
    

    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        } else {
            alertTheUser(title: "Could not log out", message: "Logout unsuccessful. Please try again later.")
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil)
    }


} //class
