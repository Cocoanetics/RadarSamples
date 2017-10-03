//
//  ViewController.swift
//  InterfaceTest
//
//  Created by Oliver Drobnik on 03.10.17.
//  Copyright © 2017 Cocoanetics. All rights reserved.
//

import UIKit

import Module

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let customClass = CustomView(frame: .zero)
		customClass.publicProperty = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

