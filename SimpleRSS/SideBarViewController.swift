//
//  SideBarViewController.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/16.
//

import Cocoa
import Alamofire
import SwiftyJSON

class SidebarViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var feed: Feed! {
        didSet {
            request(feed.getJsonURL()).responseData { response in
                var isOK = false
                print("------------------------Feed----------------------")
                if let values = response.result.value {
                    let json = JSON(values)
                    print("Feed from \(json["feed"]["title"])")
                    self.view.window?.title = json["feed"]["title"].stringValue
                    print("--------------------------------------------------")
                    json["items"].forEach { i, value in
                        print("Title: \(value["title"].string!)")
                        print("  URL: \(value["link"].string!)")
                        print("--------------------------------------------------")
                        isOK = true
                    }
                } else {
                    print("Error")
                    print(response.result.error ?? "Unknown Error")
                    print(response.result.error?.localizedDescription ?? "No Description...")
                    print("--------------------------------------------------")
                    isOK = true
                }
                if !isOK {
                    print("Unknown Error")
                    print("--------------------------------------------------")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
