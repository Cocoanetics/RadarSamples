//
//  ViewController.swift
//  PrefetchingSample
//
//  Created by Stefan Gugarel on 30/09/2016.
//  Copyright © 2016 Stefan Gugarel. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
//		let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//		layout.del
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return 100
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
		
		NSLog("Cell for row at indexPath: \(indexPath)")
		
		cell.textLabel.text = "\(indexPath.row)"
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		
		NSLog("Prefetching indexPath: \(indexPaths)")
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
	
		NSLog("Cancel prefetching indexPath: \(indexPaths)")
	}
	

	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return self.view.bounds.size
	}
}


