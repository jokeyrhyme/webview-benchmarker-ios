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
    var result: String = ""
    var delegate: BenchmarkDelegate? = nil
    
    init(webView: UIWebView) {
        self.webView = webView
    }
    
    func start() {
        var url: String = "https://google.com/"
        var request = NSURLRequest(URL: NSURL(string: url)!)
        self.webView.loadRequest(request)
    }
    
    func extractResult() -> String {
        var script: String = "document.querySelector('body').textContent"
        var result: String = self.webView.stringByEvaluatingJavaScriptFromString(script)!
        return result
    }
    
    func isComplete() -> Bool {
        var result: String = self.extractResult()
        if (~result.isEmpty) {
            self.result = result
            return true
        }
        return false
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
        whenComplete(10 * NSEC_PER_SEC)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println("webViewDidStartLoad")
    }
    
    func didSucceed() {
        println("didSucceed")
        if (self.delegate != nil) {
            self.delegate!.benchmarkDidSucceed(self)
        }
    }
    
    func didFail() {
        println("didFail")
        if (self.delegate != nil) {
            self.delegate!.benchmarkDidFail(self)
        }
    }
    
    // http://stackoverflow.com/questions/25951980/swift-do-something-every-x-minutes
    private func whenComplete(timeout: UInt64) {
        let queue = dispatch_get_main_queue()
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        let delay: UInt64 = 1 * NSEC_PER_SEC
        var elapsed: UInt64 = 0
        // every 60 seconds, with leeway of 1 second
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, delay, 1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer) {
            // do whatever you want here
            elapsed = elapsed + delay
            if (elapsed >= timeout) {
                dispatch_source_cancel(timer)
                self.didFail()
            }
            var result: Bool = self.isComplete()
            if (result) {
                dispatch_source_cancel(timer)
                self.didSucceed()
            }
        }
        dispatch_resume(timer)
    }
    
}

protocol BenchmarkProtocol {
    func benchmarkDidSucceed()
    func benchmarkDidFail()
    func isComplete() -> Bool
    func extractResult() -> String
}

protocol BenchmarkDelegate : NSObjectProtocol {
    func benchmarkDidSucceed(benchmark: Benchmark)
    func benchmarkDidFail(benchmark: Benchmark)
}

