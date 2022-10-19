//
//  Feed.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/17.
//

import Cocoa
import Alamofire
import SwiftyJSON

/// RSSフィード。
class Feed: NSObject, NSCoding {
    /// RSS の URL。
    let url: String
    /// RSS のタイトル。
    var title: String {
        var loadTitle = ""
        let jsonURL = "https://api.rss2json.com/v1/api.json?rss_url=\(self.url)"
        request(jsonURL).responseData { response in
            if let values = response.result.value {
                let json = JSON(values)
                loadTitle = json["feed"]["title"].stringValue
                print(loadTitle)
            }
        }
        return loadTitle
    }
    
    init(_ aURL: String) {
        url = aURL
    }
    
    required init?(coder aDecoder: NSCoder) {
        url = aDecoder.decodeObject(forKey: "url") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(url, forKey: "url")
    }
    
    /// RSS を Json に変換する API の URL を取得します。
    func getJsonURL() -> String {
        return "https://api.rss2json.com/v1/api.json?rss_url=\(url)"
    }
}

extension UserDefaults {
    func feed(forKey key: String) -> Feed? {
        if let storedData = self.object(forKey: key) as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? Feed {
                return unarchivedObject
            }
        }
        return nil
    }
    
    func feedArray(forKey key: String) -> [Feed]? {
        if let storedData = self.object(forKey: key) as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Feed] {
                return unarchivedObject
            }
        }
        return nil
    }

    func setFeed(_ feed: Feed, forKey key: String) {
        var data: Data!
        if #available(macOS 10.13, *) {
            data = try! NSKeyedArchiver.archivedData(withRootObject: feed, requiringSecureCoding: false)
        } else {
            data = try! NSKeyedArchiver.archivedData(withRootObject: feed)
        }
        self.set(data, forKey: key)
    }
    
    func setFeedArray(_ feeds: [Feed], forKey key: String) {
        var data: Data!
        if #available(macOS 10.13, *) {
            data = try! NSKeyedArchiver.archivedData(withRootObject: feeds, requiringSecureCoding: false)
        } else {
            data = try! NSKeyedArchiver.archivedData(withRootObject: feeds)
        }
        self.set(data, forKey: key)
    }
}
