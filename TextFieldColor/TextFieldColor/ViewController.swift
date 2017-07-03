//
//  ViewController.swift
//  TextFieldColor
//
//  Created by Stefan Gugarel on 03/07/2017.
//  Copyright © 2017 Stefan Gugarel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var dark = true
	
	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
		self.view.addGestureRecognizer(tapGestureRecognizer)
		
		updateColors()
	}
	
	@objc func tapped(gestureRecognizer: UIGestureRecognizer) {
		
		textField.resignFirstResponder()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func changeColorPressed(_ sender: Any) {
		
		dark = !dark
		
		updateColors()
	}
	
	func updateColors() {
		
		
		if dark {
			view.backgroundColor = .black
			textField.backgroundColor = .black
			textField.textColor = .white
		} else {
			view.backgroundColor = .white
			textField.backgroundColor = .white
			textField.textColor = .black
		}
		
	}
}

