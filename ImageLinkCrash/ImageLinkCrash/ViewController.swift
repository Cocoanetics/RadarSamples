//
//  ViewController.swift
//  ImageLinkCrash
//
//  Created by Stefan Gugarel on 28/07/2017.
//  Copyright © 2017 Stefan Gugarel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var textView: UITextView!
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		let image = UIImage(named: "ScalpelSi")
		
		// Image attachment
		let textAttachment = NSTextAttachment()
		textAttachment.image = image
		
		// Create attributed string
		let attributedString = NSAttributedString(attachment: textAttachment)
		let mutableString = NSMutableAttributedString(attributedString: attributedString)

		// Add Link
		mutableString.addAttributes([NSLinkAttributeName : "http://www.cannondale.com/"], range: NSMakeRange(0, mutableString.length))
		
		textView.attributedText = mutableString
		textView.isSelectable = true
	}
}

