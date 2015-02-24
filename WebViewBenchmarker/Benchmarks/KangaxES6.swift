//
//  KangaxES6.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 24/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import Foundation
import WebKit

class KangaxES6: Benchmark {
    
    override func start() {
        var url: String = "http://kangax.github.io/compat-table/es6/"
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
    override func extractResult() -> String {
        var script: String = "document.querySelector('th.current sup.num-features').textContent"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        return result
    }
    
}