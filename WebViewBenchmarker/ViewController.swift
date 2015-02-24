//
//  ViewController.swift
//  WebViewBenchmarker
//
//  Created by Ron Waldon on 23/02/2015.
//  Copyright (c) 2015 Ron Waldon. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate, BenchmarkDelegate {
    @IBOutlet var containerView: UIView? = nil
    @IBOutlet var webView: UIWebView?
    
    var benchmark: Benchmark?
    
    override func loadView() {
        super.loadView()
        
        self.webView = UIWebView()
        self.view = self.webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.benchmark = HTML5Test(webView: self.webView!)
        self.benchmark!.delegate = self
        self.webView!.delegate = self
        self.benchmark!.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return self.benchmark!.webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        return self.benchmark!.webView(webView, didFailLoadWithError: error)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        return self.benchmark!.webViewDidFinishLoad(webView)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        return self.benchmark!.webViewDidStartLoad(webView)
    }
    
    func benchmarkDidFail(benchmark: Benchmark) {
        println("benchmarkDidFail")
    }
    
    func benchmarkDidSucceed(benchmark: Benchmark) {
        println("benchmarkDidSucceed")
        println("benchmark result: " + benchmark.result)
    }

}

