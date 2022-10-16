//
//  RSSClient.swift
//  SimpleRSS
//
//  Created by shuntaro on 2022/10/16.
//

import Foundation
import Cocoa

class RSSClient {
    static func fetchItems(url: String, complete completion: @escaping (Result<[Item], Error>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            print("[ERR] invalid URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, responce, error in
            if let error = error {
                completion(.failure(error))
                print("[ERR] \(error.localizedDescription)")
            }
            guard let data = data else {
                completion(.failure(URLError(.unknown)))
                print("[ERR] unknown error")
                return
            }
            let decoder = JSONDecoder()
            guard let articleList = try? decoder.decode(ArticleList.self, from: data) else {
                completion(.failure(URLError(.unknown)))
                print("[ERR] invalid responce")
                return
            }
            completion(.success(articleList.items))
        })
        task.resume()
    }
}

public enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}
