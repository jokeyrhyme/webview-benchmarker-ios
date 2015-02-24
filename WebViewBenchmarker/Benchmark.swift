//
//  Benchmark.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 23/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class Benchmark: NSObject, UIWebViewDelegate {
    private var webView: UIWebView
    
    init(webView: UIWebView) {
        self.webView = webView
    }
    
    func start() {
        var url: String = "https://google.com/"
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
    func isComplete() {
        var script: String = "document.querySelector('body').textContent"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        println(result)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        println("shouldStartLoadWithRequest")
        return true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        println("didFailLoadWithError")
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        println("webViewDidFinishLoad")
        
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.isComplete()
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println("webViewDidStartLoad")
    }
    
}

protocol BenchmarkProtocol {
}

