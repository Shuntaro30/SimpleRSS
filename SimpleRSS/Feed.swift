//
//  File.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/16.
//
// https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://menthas.com/infrastructure/rss
//

import Foundation

/// RSSから取得する記事のリスト。
struct ArticleList: Codable {
    let status: String
    let feed: Feed
    let items: [Item]
}
/// フィード。
struct Feed: Codable {
    let url: String
    let title: String
    let link: String
    let author: String
    let description: String
}
/// 記事の詳細。
struct Item: Codable {
    let title: String
    let pubDate: String
    let link: String
    let guid: String
}
