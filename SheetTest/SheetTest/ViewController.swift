//
//  ViewController.swift
//  SheetTest
//
//  Created by Stefan Gugarel on 18/01/2017.
//  Copyright © 2017 Stefan Gugarel. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func sheetButtonPressed(_ sender: Any) {
		
		let storyboard = NSStoryboard.init(name: "Main", bundle: nil)
		let sheet = storyboard.instantiateController(withIdentifier: "SheetViewController") as! SheetViewController
		
		self.presentViewControllerAsSheet(sheet)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			
			self.dismissViewController(sheet)
		}
	}
}

