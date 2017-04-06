//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!

    @IBOutlet weak var bgMapView: MKMapView!
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    // to click image
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the tap gesture for the image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapCamera(_:)))
        
        // set user interaction
        cameraImageView.isUserInteractionEnabled = true
        
        // set the tap gesture recognizer
        cameraImageView.addGestureRecognizer(tapGestureRecognizer)
            
            

        // Do any additional setup after loading the view.
        bgMapView.delegate = self
        
        // One degree of latitude is approximately 111 kilometers (69 miles) at all times.
        // San Francisco Lat, Long = latitude: 37.783333, longitude: -122.416667
        let mapCenter = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        // Set animated property to true to animate the transition to the region
        bgMapView.setRegion(region, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onTapCamera(_ sender: UITapGestureRecognizer) {
        // make the camera grow when pressed
        print("bruh, the button was pressed my man")
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
