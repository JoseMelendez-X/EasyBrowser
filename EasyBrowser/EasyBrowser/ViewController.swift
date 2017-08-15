//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Jose Melendez on 8/14/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

//Frameworks
import WebKit
import UIKit

//Conform to the WKNavigation protocol
class ViewController: UIViewController, WKNavigationDelegate {
    
    //WKWebView object displays interactive web content
    
    var webView: WKWebView!
    
    //Progress View
    var progressView: UIProgressView!
    
    //Websites
    var websites = ["apple.com", "youtube.com", "nasa.gov", "techcrunch.com"]
    
    //Hide the status bar
    override var prefersStatusBarHidden: Bool {
        
        return true
    }

    override func loadView() {
        
        //Create a WKWebView Object
        webView = WKWebView()
        
        //Assign the webView navigationDelegate to the current class (self)
        webView.navigationDelegate = self
        
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding a button to the navigation bar and calling a function when it's tapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //Add flexible space so that it can take as much room as it can to the right.
        //target and action are nil because flexible space cannot be tapped.
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //Create a progress view with the default styling
        progressView = UIProgressView(progressViewStyle: .default)
        
        //Set the layout size of the progressView so that it fits its content fully
        progressView.sizeToFit()
        
        //Wrap the progressView in a UIBarButtonItem so that it can go in our toolbar
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        //What our toolbar contains
        toolbarItems = [progressButton, spacer, refresh]
        
        //Key value observing, add an observer
       webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        //Show the toolbar
        navigationController?.isToolbarHidden = false
        
        //The location of a resource on a remote server. Create the url
        //URL has to be http"s" not http
        let url = URL(string: "https://" + websites[0])!
        
        //load the URL Requeset
        webView.load(URLRequest(url: url))
        
        //Allow back forward navigation
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    //Tells you when the observe value has changed
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            
            progressView.progress = Float(webView.estimatedProgress)
            
        }
    }

    
    //openTapped Function
    func openTapped() {
        
        //Create the alert controller 
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            
            //Add actions
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
            
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
        
        
    }
    
    //openPage Function
    func openPage(action: UIAlertAction){
        
        let url = URL(string: "https://" + action.title!)!
        
        webView.load(URLRequest(url: url))
        
    }
    
    //Delegate method from WKWebView
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        title = webView.title
    }
    
    //This function allows us to determine wether or not we want navigation to happen
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url!.host {
            
            for website in websites {
                
                if host.range(of: website) != nil {
                    
                    decisionHandler(.allow)
                    
                    return
                }
            }
        }
        decisionHandler(.cancel)
        
    }

}

