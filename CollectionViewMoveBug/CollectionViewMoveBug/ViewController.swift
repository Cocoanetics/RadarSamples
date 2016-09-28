//
//  ViewController.swift
//  CollectionViewBug
//
//  Created by Stefan Gugarel on 16.9.2016
//  Copyright © 2016 Stefan Gugarel. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSCollectionViewDataSource {
	
	var data = [["1", "2"], ["3"], ["4", "5"]]
	
	@IBOutlet weak var collectionView: NSCollectionView!
	
	
	// MARK: - View lifecycle
	
	override func viewWillAppear() {
		super.viewWillAppear()
		
		self.collectionView.layer?.backgroundColor = NSColor.purple.cgColor
	}

	
	// MARK: - NSCollectionViewDataSource
	
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return data[section].count
	}
	
	func numberOfSections(in collectionView: NSCollectionView) -> Int {
		return data.count
	}
	
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		
		let item = collectionView.makeItem(withIdentifier: "LabelCollectionViewItem", for: indexPath as IndexPath) as!LabelCollectionViewItem
		
		item.label.stringValue = data[indexPath.section][indexPath.item]
		
		return item
	}
	
	
	// MARK: - Move section down
	
	@IBAction func moveDownAction(sender: AnyObject) {
	
		// Move sections
		let section0 = data[0]
		data.remove(at: 0)
		data.insert(section0, at: 1)
		
		// Animate section movement
		collectionView.animator().moveSection(0, toSection: 2)
	}
}

