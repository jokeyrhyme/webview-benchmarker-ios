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
    
    var benchmarks: [Benchmark] = [
        HTML5Test(),
        CSS3Test(),
        KangaxES6(),
        KangaxES7()
    ]
    var benchmark: Benchmark? = nil
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBenchmark()
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
        self.nextBenchmark()
    }
    
    func benchmarkDidSucceed(benchmark: Benchmark) {
        //println("benchmarkDidSucceed")
        println("benchmark result: " + benchmark.result)
        self.nextBenchmark()
    }
    
    func destroyBenchmark() {
        if (self.benchmark != nil) {
            self.benchmark!.delegate = nil
            self.benchmark!.webView.delegate = nil
            self.benchmark = nil
        }
    }
    
    func nextBenchmark() {
        var previous: Benchmark? = nil
        if (self.benchmark != nil) {
            previous = self.benchmark!
        }
        
        destroyBenchmark()
        
        var benchmark: Benchmark
        if (previous == nil) {
            benchmark = benchmarks[0]
        } else {
            var index = find(self.benchmarks, previous!)
            if (index == nil) {
                println("unknown benchmark somehow !?!")
                return
            }
            if (previous != self.benchmarks.last) {
                benchmark = self.benchmarks[index! + 1]
            } else {
                println("all done!")
                return
            }
        }
        
        self.benchmark = benchmark
        
        self.view = benchmark.webView
        
        benchmark.delegate = self
        benchmark.webView.delegate = self
        benchmark.start()
    }

}

