//
//  PanelViewController.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/19.
//

import Cocoa

class PanelViewController: NSViewController {
    
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func cancel(_ sender: Any) {
        let previousVC = view.window?.windowController as? MainWindowController
        previousVC?.addFeed("canceled")
        dismiss(self)
    }
    
    @IBAction func add(_ sender: Any) {
        let previousVC = view.window?.windowController as? MainWindowController
        previousVC?.addFeed(textField.stringValue)
        dismiss(self)
    }
    
}
