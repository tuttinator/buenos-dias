//
//  ViewController.swift
//  buenos dias
//
//  Created by Caleb Tutty on 14/07/14.
//  Copyright (c) 2014 Supervillains and Associates. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, NSNetServiceBrowserDelegate {
    var services = []
    let serviceBrowser = NSNetServiceBrowser()
    var serviceResolver = NSNetService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceBrowser.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // UITableViewDataSourceDelegate
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if(self.services.count == 0) {
            return 1
        } else {
            return self.services.count
        }
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        if(self.services.count == 0) {
            cell.textLabel.text = "Searching"
        } else {
            cell.textLabel.text = self.services[indexPath.row].name
        }
        
        return cell
    }
    
    // UITableViewDelegate
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.serviceResolver.stop()
        
        
        if(self.services.count != 0) {
            
        }
    }

}

