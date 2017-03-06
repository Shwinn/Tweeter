//
//  TweetCell.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 2/26/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

protocol TweetCellDelegator{
    func callSegueFromCell(user: User)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    var delegate: TweetCellDelegator!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            let difference = String(Int(Date().timeIntervalSince(tweet.timestamp!)) / 60)
            timestampLabel.text = String("" + difference + " m ago")
            nameLabel.text = tweet.tweeterName
            profilePictureImageView.setImageWith(URL(string: tweet.tweeterProfileUrl!)!)
            
            if(tweet.isRetweeted)!{
                retweetButton.setBackgroundImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
            else {
                retweetButton.setBackgroundImage(UIImage.init(named: "retweet-icon"), for: UIControlState.normal)
            }
            
            if(tweet.isFavorited!){
                favoriteButton.setBackgroundImage(UIImage(named: "favor-icon-1"), for: .normal)
            }
            else {
                favoriteButton.setBackgroundImage(UIImage.init(named: "favor-icon"), for: UIControlState.normal)   
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
            profilePictureImageView.isUserInteractionEnabled = true
            profilePictureImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tweetUser = User.init(dictionary: tweet.userDic!)
        self.delegate.callSegueFromCell(user: tweetUser)
        //performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        tweet.isRetweeted = !(tweet.isRetweeted!)
        if (tweet.isRetweeted!){
            retweetButton.setBackgroundImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else {
            retweetButton.setBackgroundImage(UIImage.init(named: "retweet-icon"), for: UIControlState.normal)
        }
        TwitterClient.sharedInstance?.retweet(tweetId: tweet.tweetId!, success: { () in
            
        }, failure: { (error: Error) in
            
        })
    }
    @IBAction func onFavoriteButton(_ sender: Any) {
        tweet.isFavorited = !(tweet.isFavorited!)
        if(tweet.isFavorited!){
            favoriteButton.setBackgroundImage(UIImage(named: "favor-icon-1"), for: .normal)
        }
        else {
            favoriteButton.setBackgroundImage(UIImage.init(named: "favor-icon"), for: UIControlState.normal)
        }
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
