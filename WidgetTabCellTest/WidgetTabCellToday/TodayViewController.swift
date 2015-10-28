//
//  TodayViewController.swift
//  WidgetTabCellToday
//
//  Created by Oliver Drobnik on 28/10/15.
//  Copyright © 2015 Oliver Drobnik. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UITableViewController, NCWidgetProviding {
    
    var _defaultMarginInsets: UIEdgeInsets = UIEdgeInsetsZero
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.tableView.estimatedRowHeight = 55;
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        adjustContentSize()
    }
    
    func adjustContentSize()
    {
        var height: CGFloat = 0
        
        for var i=0; i<4; i++
        {
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            height += self.tableView .rectForRowAtIndexPath(indexPath).size.height
        }
        
        self.preferredContentSize = CGSize(width: self.tableView.frame.size.width, height: height)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func addSelectionBackground(cell: UITableViewCell)
    {
        let effect = UIVibrancyEffect.notificationCenterVibrancyEffect()
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = cell.contentView.bounds
        effectView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        let tintView = UIView(frame: effectView.bounds)
        tintView.backgroundColor = self.tableView.separatorColor
        tintView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        effectView.contentView .addSubview(tintView)
        cell.selectedBackgroundView = effectView;
        
        cell.selectionStyle = .Default;
    }
    
    
    func firstCell()->UITableViewCell
    {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell1")
        cell.textLabel!.text = "This cell seems works because the label extends over the entire width. But try clicking outside the label (left or right margin)."
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.textColor = .redColor()
 
        return cell
    }
    
    func secondCell()->UITableViewCell
    {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell1")
        cell.textLabel!.text = "No go ->"
        cell.textLabel!.textColor = .redColor()
        cell.textLabel!.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        
        cell.detailTextLabel!.textColor = .redColor()
        cell.detailTextLabel!.text = "<-"
        
        return cell
    }
    
    func thirdCell()->UITableViewCell
    {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell1")
        cell.textLabel!.text = "Workaround!"
        cell.textLabel!.textColor = .greenColor()
        
        cell.detailTextLabel!.textColor = .greenColor()
        cell.detailTextLabel!.text = "<-"
        
        // workaround that "activates" the cell
        cell.backgroundColor = UIColor(white: 0, alpha: 0.005)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch indexPath.row
        {
        case 0:
            return firstCell()
        case 1:
            return secondCell()
        default:
            return thirdCell()
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: _defaultMarginInsets.left, bottom: 0, right: _defaultMarginInsets.right)
        
        if let textLabel = cell.textLabel
        {
            textLabel.layer.borderColor = textLabel.textColor.colorWithAlphaComponent(0.2).CGColor
            textLabel.layer.borderWidth = 0.5
        }
        
        if let detailTextLabel = cell.detailTextLabel
        {
            detailTextLabel.layer.borderColor = detailTextLabel.textColor.colorWithAlphaComponent(0.2).CGColor
            detailTextLabel.layer.borderWidth = 0.5
        }
        
        addSelectionBackground(cell)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        _defaultMarginInsets = defaultMarginInsets
        
        var newInsets = defaultMarginInsets
        newInsets.left = 0
        
        return newInsets
    }
    
  
}
