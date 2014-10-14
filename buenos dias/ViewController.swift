//
//  ViewController.swift
//  buenos dias
//
//  Created by Caleb Tutty on 14/07/14.
//  Copyright (c) 2014 Supervillains and Associates. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, NSNetServiceBrowserDelegate, NSNetServiceDelegate {
    var serviceList = NSMutableArray()
    let serviceBrowser = NSNetServiceBrowser()
    var serviceResolver = NSNetService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceBrowser.delegate = self
        self.searchForBonjourServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchForBonjourServices() {
        // types:
        // https://developer.apple.com/library/mac/qa/qa1312/_index.html
        
        self.serviceBrowser.searchForServicesOfType("_http._tcp", inDomain: "local.")
        //self.serviceBrowser.searchForServicesOfType("_music._tcp", inDomain: "local.")
        //self.serviceBrowser.searchForServicesOfType("_daap._tcp", inDomain: "local.")
        //self.serviceBrowser.searchForServicesOfType("_printer._tcp", inDomain: "local.")
        //self.serviceBrowser.searchForServicesOfType("_ipp._tcp", inDomain: "local.")
        //self.serviceBrowser.searchForServicesOfType("_eppc._tcp", inDomain: "local.")
        //self.serviceBrowser.searchForServicesOfType("_ssh._tcp", inDomain: "local.")
        //self.serviceBrowser.searchForServicesOfType("_afpovertcp._tcp", inDomain: "local.")
        
        // AirTunes (and AirPlay)
        //self.serviceBrowser.searchForServicesOfType("_raop._tcp", inDomain: "local.")
        
    }

    
    // UITableViewDataSourceDelegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.serviceList.count == 0) {
            return 1
        } else {
            return self.serviceList.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if !(cell != nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        
        if(self.serviceList.count == 0) {
            cell!.textLabel!.text = "Searching"
        } else {
            cell!.textLabel!.text = self.serviceList[indexPath.row].name
        }
        
        return cell!
    }
    
    // UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.serviceResolver.stop()
        
        
        if(self.serviceList.count != 0) {
            self.serviceResolver = self.serviceList[indexPath.row] as NSNetService
            self.serviceResolver.delegate = self
            self.serviceResolver.resolveWithTimeout(0.0)
        }
    }
    
    // NSNetServiceDelegate
    func netServiceDidResolveAddress(sender: NSNetService!) {
        self.serviceResolver.stop()
        NSLog("\(sender)")
    }
    
    func netService(sender: NSNetService!, didNotResolve errorDict: [NSObject : AnyObject]!) {
        self.serviceResolver.stop()
        NSLog("\(errorDict)")
    }
    
    // NSNetServiceBrowserDelegate
    func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser!, didFindService aNetService: NSNetService!, moreComing: Bool) {
        
        self.serviceList.addObject(aNetService)
        
        if(!moreComing) {
            self.tableView.reloadData()
        }
    }
    
    func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser!, didRemoveService aNetService: NSNetService!, moreComing: Bool) {
        self.serviceList.removeObject(aNetService)
        
        if(!moreComing) {
            self.tableView.reloadData()
        }
    }

}

