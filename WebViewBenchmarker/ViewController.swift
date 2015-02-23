//
//  ViewController.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 23/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    //@IBOutlet var containerView: UIView = nil
    @IBOutlet var webView: UIWebView?
    
    override func loadView() {
        super.loadView()
        
        self.webView = UIWebView()
        self.view = self.webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var url = NSURL(string: "https://google.com/")
        var request = NSURLRequest(URL: url!)
        self.webView!.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

