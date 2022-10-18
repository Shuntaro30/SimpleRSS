//
//  UserDefaultsController.swift
//  
//
//  Created by shuntaro on 2022/10/18.
//

import Foundation

class UserDefaultsController {
    /// UserDefaultsに値をセットします。
    func set(_ value: Any, key: Keys) {
        switch key {
        case .lastFeed:
            UserDefaults.standard.setFeed(value as! Feed, forKey: "LastFeed")
        case .feeds:
            UserDefaults.standard.setFeedArray(value as! [Feed], forKey: "Feeds")
        }
    }
    
    /// UserDefaultsから値を読み出します。
    /// 失敗した場合は`nil`を返します。
    func get(_ key: Keys) -> Any? {
        switch key {
        case .lastFeed:
            return UserDefaults.standard.feed(forKey: "LastFeed")
        case .feeds:
            return UserDefaults.standard.feedArray(forKey: "Feeds")
        }
    }
    
    enum Keys {
        case lastFeed
        case feeds
    }
}
