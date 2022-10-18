//
//  MainWindowController.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/17.
//
//  BBC: http://feeds.bbci.co.uk/news/rss.xml
//  Yahoo: https://news.yahoo.co.jp/rss/topics/top-picks.xml
//

import Cocoa
import Alamofire
import SwiftyJSON

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var popupMenu: NSPopUpButton!
    
    var feeds = [Feed]()
    var feed: Feed!
    var user = UserDefaultsController()
    var sideBar: SidebarViewController!

    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        let splitController = contentViewController as? NSSplitViewController
        sideBar = splitController?.splitViewItems[0].viewController as? SidebarViewController
        if let feeds = user.get(.feeds) as? [Feed] {
            self.feeds = feeds
        } else {
            feed = Feed("https://news.yahoo.co.jp/rss/topics/top-picks.xml")
            user.set(feed!, key: .lastFeed)
        }
        if let lastFeed = user.get(.lastFeed) as? Feed {
            feed = lastFeed
            sideBar.feed = feed
        } else {
            feed = feeds[0]
            user.set(feeds[0], key: .lastFeed)
            sideBar.feed = feed
        }
    }
    
    @IBAction func popupDidChange(_ sender: Any?) {
        
    }

}
