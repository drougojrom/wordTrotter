//
//  ViewWebController.swift
//  WorldTrotter
//
//  Created by Roman Ustiantcev on 23/02/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit
import WebKit


class ViewWebController: UIViewController {
    
    @IBOutlet weak var webSiteView: UIWebView!
    
    override func viewDidLoad() {
        
    let url = NSURL(string: "https://www.bignerdranch.com")
    webSiteView.loadRequest(NSURLRequest(URL: url!))
    
    }
}