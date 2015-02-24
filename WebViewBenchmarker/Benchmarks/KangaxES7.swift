//
//  KangaxES7.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 24/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import Foundation
import WebKit

class KangaxES7: KangaxES6 {
    
    override func start() {
        var url: String = "http://kangax.github.io/compat-table/es7/"
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
}