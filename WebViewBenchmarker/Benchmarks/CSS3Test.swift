//
//  CSS3Test.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 24/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import Foundation
import WebKit

class CSS3Test: Benchmark {
    
    override func start() {
        var url: String = "http://css3test.com/"
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
    override func extractResult() -> String {
        var script: String = ""
        script = "document.querySelector('#passedTests').textContent"
        var passed: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        script = "document.querySelector('#totalTests').textContent"
        var total: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        return passed + "/" + total
    }
    
    override func isComplete() -> Bool {
        var script: String = "document.querySelector('#timeTaken').textContent"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        return ~result.isEmpty
    }
    
    
}