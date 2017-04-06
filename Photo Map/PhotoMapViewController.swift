//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, LocationsViewControllerDelegate {
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
        print("camera button tapped\n")
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            vc.sourceType = .camera
        } else {
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion:nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        print("selected the image")
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        pickedImage = editedImage
        
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "tagSegue", sender: self)
    }
    
    
    // after the user selects location
    func locationsPickedLocation(controller: LocationsViewController, latitude lat: NSNumber, longitude long: NSNumber) {
        print ("selected the location\(lat, long)")
        let locationCoord = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        addPinToMapView(locationCoordinate: locationCoord)
        print("added annotation")
    }
    
    // add annotation
    func addPinToMapView(locationCoordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = locationCoordinate
        pin.title = String(describing: locationCoordinate.latitude)
        bgMapView.addAnnotation(pin)
    }
    
    // detect annotation
    func mapView(_ bgMapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
            if let title = annotation.title! {
                print("Tapped \(title) pin")
            }
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let locationsViewController = segue.destination as! LocationsViewController
        locationsViewController.delegate = self
        
    }
    
    

}
