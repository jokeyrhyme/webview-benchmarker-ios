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
    var webView: UIWebView
    var result: String = ""
    var delegate: BenchmarkDelegate? = nil
    
    override init() {
        self.webView = UIWebView()
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
        return ~result.isEmpty
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        println("didFailLoadWithError")
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        println("webViewDidFinishLoad")
        self.pollUntil(self.isComplete, done: self.didComplete, timeout: 10 * NSEC_PER_SEC)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        //println("webViewDidStartLoad")
    }
    
    func didComplete(err: NSError?) {
        if (err != nil) {
            if (self.delegate != nil) {
                self.delegate!.benchmarkDidFail(self)
            }
        } else {
            self.result = self.extractResult()
            if (self.delegate != nil) {
                self.delegate!.benchmarkDidSucceed(self)
            }
        }
    }
    
    // http://stackoverflow.com/questions/25951980/swift-do-something-every-x-minutes
    private func pollUntil(check: (() -> Bool), done: ((err: NSError?) -> Void), timeout: UInt64) {
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
                done(err: NSError(domain: "pollUntil", code: 1, userInfo: NSDictionary()))
            }
            var result: Bool = check()
            if (result) {
                dispatch_source_cancel(timer)
                done(err: nil)
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

