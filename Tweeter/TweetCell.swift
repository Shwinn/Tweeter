//
//  TweetCell.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 2/26/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            let difference = String(Int(Date().timeIntervalSince(tweet.timestamp!)) / 60)
            timestampLabel.text = String("" + difference + " m ago")
            nameLabel.text = tweet.tweeterName
            profilePictureImageView.setImageWith(URL(string: tweet.tweeterProfileUrl!)!)
            retweetButton.setBackgroundImage(UIImage.init(named: "retweet-icon"), for: UIControlState.normal)
            favoriteButton.setBackgroundImage(UIImage.init(named: "favor-icon"), for: UIControlState.normal)
        }
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        TwitterClient.sharedInstance?.retweet(tweetId: tweet.tweetId!, success: { () in
            
        }, failure: { (error: Error) in
            
        })
    }
    @IBAction func onFavoriteButton(_ sender: Any) {
        TwitterClient.sharedInstance?.favorite(tweetId: tweet.tweetId!, success: {
            
        }, failure: { (error: Error) in
            
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
