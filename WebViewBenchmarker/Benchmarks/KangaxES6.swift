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
    
    override func load() {
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

    override func isComplete() -> Bool {
        var script: String = "'' + Array.prototype.slice.call(document.querySelectorAll('td.current')).every(function (td) { return td.className.indexOf('no') !== -1 || td.className.indexOf('yes') !== -1 || td.className.indexOf('tally') !== -1 })"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        return result == "true"
    }

}