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

    override func load() {
        var url: String = "http://html5test.com/"
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
    override func extractResult() -> String {
        var script: String = "document.querySelector('.pointsPanel h2 strong').textContent"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        return result
    }
    
}