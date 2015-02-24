//
//  HTML5Test.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 24/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import Foundation
import WebKit

class HTML5Test: Benchmark {

    private var webView: UIWebView
    
    override init(webView: UIWebView) {
        self.webView = webView
        super.init(webView: webView)
    }
    
    override func start() {
        var url: String = "https://html5test.com/"
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
    override func extractResult() -> String {
        var script: String = "document.querySelector('.pointsPanel h2 strong').textContent"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        return result
    }

    override func isComplete() -> Bool {
        var result: String = self.extractResult()
        if (~result.isEmpty) {
            self.result = result
            return true
        }
        return false
    }

    
}