//
//  SwiftViewController.swift
//  Module
//
//  Created by Oliver Drobnik on 03.10.17.
//  Copyright © 2017 Cocoanetics. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// here the quick help shows something on the class and property
		let customClass = CustomView(frame: .zero)
		customClass.publicProperty = true
	}
}
