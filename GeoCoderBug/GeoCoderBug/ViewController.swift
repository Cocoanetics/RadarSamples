//
//  ViewController.swift
//  GeoCoderBug
//
//  Created by Oliver Drobnik on 23/04/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBook
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
	
	@IBOutlet weak var mapView1: MKMapView!
	@IBOutlet weak var mapView2: MKMapView!
	
	override func viewDidAppear(animated: Bool)
	{
		super.viewDidAppear(animated)
		
		// two mis-parsed addresses
		
		var dict1 = [
			kABPersonAddressCityKey as! String: "Vienna",
			kABPersonAddressZIPKey as! String: "1110",
			kABPersonAddressStreetKey as! String: "Rinnböckstrasse 48/17",
			kABPersonAddressCountryKey as! String: "Austria"
		]
		
		var dict2 = [
			kABPersonAddressCityKey as! String: "Vienna",
			kABPersonAddressZIPKey as! String: "1110",
			kABPersonAddressStreetKey as! String: "Rosa-Jochmann-Ring 42/4/5/30",
			kABPersonAddressCountryKey as! String: "Austria"
		]
		
		geocodeAddressDictionary(dict1, forMapView: mapView1)
		geocodeAddressDictionary(dict2, forMapView: mapView2)
		
		// show the correct addresses as well
		
		var dict3 = [
			kABPersonAddressCityKey as! String: "Vienna",
			kABPersonAddressZIPKey as! String: "1110",
			kABPersonAddressStreetKey as! String: "Rinnböckstrasse 48",
			kABPersonAddressCountryKey as! String: "Austria"
		]
		
		var dict4 = [
			kABPersonAddressCityKey as! String: "Vienna",
			kABPersonAddressZIPKey as! String: "1110",
			kABPersonAddressStreetKey as! String: "Rosa-Jochmann-Ring 42",
			kABPersonAddressCountryKey as! String: "Austria"
		]
		
		geocodeAddressDictionary(dict3, forMapView: mapView1)
		geocodeAddressDictionary(dict4, forMapView: mapView2)
	}

	func geocodeAddressDictionary(dictionary: [NSObject : AnyObject]!, forMapView: MKMapView!)
	{
		var coder = CLGeocoder()
		coder .geocodeAddressDictionary(dictionary, completionHandler: { (result, error) -> Void in
			if result.isEmpty
			{
				return
			}
			
			if let placemark = result[0] as? CLPlacemark
			{
				var pin = MKPlacemark( placemark: placemark)
				
				// add this pin as placemark to map
				forMapView.addAnnotation(pin)
				
				
				var region = MKCoordinateRegion(center: pin.location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
				
				// center map on new pin
				forMapView.setRegion(region, animated: true)
			}
		});
	}
	
	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!
	{
		if let placemark = annotation as? MKPlacemark
		{
			var addressDict = placemark.addressDictionary
			var street = addressDict[kABPersonAddressStreetKey as String] as! String
			var pav = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil);
			pav.canShowCallout = true
			
			if (street.hasSuffix("42") || street.hasSuffix("48"))
			{
				// correct pin
				pav.pinColor = .Green
			}
			else
			{
				// incorrect pin
				pav.pinColor = .Red
			}
			
			return pav
		}
		
		return nil
	}
}

