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
    private var url: String = "https://google.com/"
    private var webView: UIWebView
    
    init(webView: UIWebView) {
        self.webView = webView
    }
    
    func start() {
        var request = NSURLRequest(URL: NSURL(string: self.url)!)
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
        self.isComplete()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println("webViewDidStartLoad")
    }
    
}

