//
//  Feed.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/17.
//

import Foundation

struct Feed {
    /// RSS の URL。
    let url: String
    /// RSSフィードのタイトル。
    let title: String
    /// RSSをJsonに変換するAPIのURLを取得します。
    func getJsonURL() -> String {
        return "https://api.rss2json.com/v1/api.json?rss_url=\(url)"
    }
}
