//
//  APIController.swift
//  D04
//
//  Created by Duane HERVY on 1/12/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class APIController: NSObject {

    weak var delegate : APITwitterDelegate?
    let token : String?
    var tweets: [Tweet]

    init(delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
        self.tweets = []
        super.init()
    }
    
    func dateStringFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z y"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
        let dateFormat = dateFormatter.string(from: date!)
        return dateFormat
    }
    
    func getTweet(query: String) {
        self.tweets = []
        var urlComponent = URLComponents(string: "https://api.twitter.com/1.1/search/tweets.json")!
        
        urlComponent.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "tweet_mode", value: "extended")
        ]
        
        urlComponent.percentEncodedQuery = urlComponent.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = NSMutableURLRequest(url: urlComponent.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + self.token!, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                self.delegate?.handleError(error: err as NSError)
            }
            else if let d = data {
                do {
                    if let dict : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let tweets_resp = dict["statuses"] as? [NSDictionary] {
                            for tweet in tweets_resp {
                                if let user = tweet["user"] as? NSDictionary,
                                    let date = tweet["created_at"] as? String,
                                    let text = tweet["full_text"] as? String,
                                    let name = user["name"] as? String {
                                    let dateFormat = self.dateStringFormat(dateString: date)
                                    self.tweets.append(Tweet(name: name, text: text, date: dateFormat))
                                }
                            }
                            self.delegate?.handleTweet(tweets: self.tweets)
                        }
                    }
                }
                catch (let err) {
                    self.delegate?.handleError(error: err as NSError)
                }
            }
        }
        task.resume()
    }
    
}
enum ErrorsToThrow: Error {
    case fileNotFound
    case fileNotReadable
    case fileSizeIsTooHigh
}
