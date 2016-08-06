//
//  MenuTableViewController.swift
//  RxAVCaptureSessionSample
//
//  Created by Takeru Chuganji on 8/4/16.
//  Copyright © 2016 Takeru Chuganji. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    private enum SegueIdentifier: String {
        case QRCodeCaptureViewController
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            performSegueWithIdentifier(SegueIdentifier.QRCodeCaptureViewController.rawValue, sender: tableView.cellForRowAtIndexPath(indexPath))
        case _:
            break
        }
    }
    
}
