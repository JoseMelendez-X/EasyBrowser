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
    

    override func loadView() {
        
        //Create a WKWebView Object
        webView = WKWebView()
        
        //Assign the webView navigationDelegate to the current class (self)
        webView.navigationDelegate = self
        
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The location of a resource on a remote server. Create the url
        //URL has to be http"s" not http
        let url = URL(string: "https://www.youtube.com/")!
        
        //load the URL Requeset
        webView.load(URLRequest(url: url))
        
        //Allow back forward navigation
        webView.allowsBackForwardNavigationGestures = true
        
    }

}

