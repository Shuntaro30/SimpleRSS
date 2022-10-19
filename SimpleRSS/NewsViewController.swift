//
//  ViewController.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/16.
//

import Cocoa
import WebKit

class NewsViewController: NSViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func load() {
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: URL(string: self.url) ?? URL(fileURLWithPath: "")))
        }
    }
    
}
