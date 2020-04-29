//
//  ViewController.swift
//  07 WebView
//
//  Created by Gukhwa Jeon on 28.04.20.
//  Copyright © 2020 G-Kay. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    // load initial webpage
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!) // myUrl is optional variable. must be unwrapped
        myWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        loadWebPage("https://github.com/jeon7")
    }
    
    // when loading
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }

    // when loading is finished
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    // when loading is failed
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func checkURL(_ url: String) -> String {
        var strUrl = url
        let flagHttp = strUrl.hasPrefix("http://")
        let flagHttps = strUrl.hasPrefix("https://")
        if !(flagHttp || flagHttps)  {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkURL(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("https://www.google.com") // https:// 붙여줘야함
    }
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://www.naver.com") // http:// 도 가능
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1> <p> String 변수를 이용한 웹 페이지 </p> <p><a href=\"https://github.com\">github으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
    
}

