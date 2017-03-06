//
//  Tweet.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 2/26/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var tweeterProfileUrl: String?
    var tweeterName: String?
    var tweetId: String?
    var tweeterUsername: String?
    var isRetweeted: Bool?
    var isFavorited: Bool?
    var userDic: NSDictionary?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        tweeterName = (dictionary["user"] as? NSDictionary)?["name"] as? String
        tweeterProfileUrl = (dictionary["user"] as? NSDictionary)?["profile_image_url"] as? String
        tweetId = dictionary["id_str"] as? String
        tweeterUsername = (dictionary["user"] as? NSDictionary)?["screen_name"] as? String
        isRetweeted = dictionary["retweeted"] as? Bool
        isFavorited = dictionary["favorited"] as? Bool
        userDic = dictionary["user"] as? NSDictionary
        
        
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }

    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }

}
