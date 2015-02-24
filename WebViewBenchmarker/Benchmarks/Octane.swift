//
//  Octane.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 24/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import Foundation
import WebKit

class Octane: Benchmark {
    
    override init() {
        super.init()
        self.timeout = 90 * NSEC_PER_SEC
        self.delay = 5 * NSEC_PER_SEC
    }
    
    override func load() {
        var url: String = "http://octane-benchmark.googlecode.com/svn/latest/index.html"
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
    override func isAutoStarted() -> Bool {
        return false
    }
    
    override func startTests() {
        var script: String = "Run()"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
    }
    
    override func extractResult() -> String {
        var script: String = "document.querySelector('#main-banner').textContent"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        result = result.stringByReplacingOccurrencesOfString("Octane Score: ", withString: "")
        result = result.stringByReplacingOccurrencesOfString("Running Octane...", withString: "")
        return result
    }
    
}