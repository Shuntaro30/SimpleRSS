//
//  PanelViewController.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/19.
//

import Cocoa

class PanelViewController: NSViewController {
    
    @IBOutlet weak var textField: NSTextField!
    
    var previousVC: MainWindowController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func cancel(_ sender: Any) {
        previousVC.addFeed("canceled")
        dismiss(self)
    }
    
    @IBAction func add(_ sender: Any) {
        print("Add \(textField.stringValue)")
        previousVC.addFeed(textField.stringValue)
        dismiss(self)
    }
    
}
