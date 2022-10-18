//
//  Feed.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/17.
//

import Cocoa

/// RSSフィード。
class Feed: NSObject, NSCoding {
    /// RSS の URL。
    let url: String
    /// RSSをJsonに変換するAPIのURLを取得します。
    func getJsonURL() -> String {
        return "https://api.rss2json.com/v1/api.json?rss_url=\(url)"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(url, forKey: "url")
    }
    
    init(_ aURL: String) {
        url = aURL
    }
    
    required init?(coder aDecoder: NSCoder) {
        url = aDecoder.decodeObject(forKey: "url") as! String
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
