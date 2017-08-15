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
        
        //The location of a resource on a remote server. Create the url
        //URL has to be http"s" not http
        let url = URL(string: "https://www.apple.com/h")!
        
        //load the URL Requeset
        webView.load(URLRequest(url: url))
        
        //Allow back forward navigation
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    //openTapped Function 
    func openTapped() {
        
        //Create the alert controller 
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        //add an action
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        
        //add an action
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        
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

}

