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
    
    @IBOutlet weak var tableView: NSTableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.rowHeight = 60
        }
    }
    
    var newsController: NewsViewController!
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
                    self.news.removeAll()
                    json["items"].forEach { i, value in
                        self.news.append(News(value["title"].string!, link: value["link"].string!, description: value["content"].string!))
                        print("Title: \(value["title"].string!)")
                        print("  URL: \(value["link"].string!)")
                        print("--------------------------------------------------")
                        isOK = true
                    }
                    self.tableView.reloadData()
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
    
    var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let result = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SidebarView"), owner: self) as? SidebarCellView
        result?.title.stringValue = news[row].title
        var description = news[row].description
        if description.isEmpty {
            description = "説明はありません。"
        }
        result?.descriptionLabel.stringValue = description
        return result
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        print("Selected Row: \(row)")
        if row >= 0 && row < news.count {
            newsController.url = news[row].link
            newsController.load()
        }
    }
    
}
