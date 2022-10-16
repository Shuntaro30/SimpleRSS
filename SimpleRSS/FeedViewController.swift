//
//  ViewController.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/16.
//

import Cocoa

class FeedViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        RSSClient.fetchItems(url: newsType.urlStr, complete: { (response) in
            switch response {
            case .success(let items):
                DispatchQueue.main.async() { [weak self] in
                    guard let me = self else { return }
                    me.items = items
                }
            case .failure(let err):
                print("記事の取得に失敗しました: reason(\(err))")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

