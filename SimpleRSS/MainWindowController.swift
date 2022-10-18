//
//  MainWindowController.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/17.
//

import Cocoa
import Alamofire
import SwiftyJSON

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var popupMenu: NSPopUpButton!
    
    var feeds = [Feed]()

    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        feeds.append(Feed(url: "http://feeds.bbci.co.uk/news/rss.xml", title: "Yahoo! News"))
        var isOK = false
        request(feeds[0].getJsonURL()).responseData { response in
            debugPrint(response)
            print("-----------Feed----------")
            if let values = response.result.value {
                print("Processing JSON...")
                JSON(values)["responseData"]["feed"]["entries"].forEach { i, value in
                    print(value["title"].string!)
                    print(value["link"].string!)
                    print("-------------------------")
                    isOK = true
                }
            } else {
                print("Error")
                print(response.result.error ?? "Unknown Error...")
                print(response.result.error?.localizedDescription ?? "No Description...")
                print("-------------------------")
                isOK = true
            }
            if !isOK {
                print("Unknown Error")
                print("-------------------------")
            }
        }
    }

}
