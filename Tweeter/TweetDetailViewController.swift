//
//  TweetDetailViewController.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 3/3/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var numOfFavoritesLabel: UILabel!
    @IBOutlet weak var numOfRetweetsLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = tweet.tweeterName
        numOfFavoritesLabel.text = String(tweet.favoritesCount)
        numOfRetweetsLabel.text = String(tweet.retweetCount)
        let difference = String(Int(Date().timeIntervalSince(tweet.timestamp!)) / 60)
        timestampLabel.text = String("" + difference + " m ago")
        tweetTextLabel.text = tweet.text
        profilePictureImageView.setImageWith(URL(string: tweet.tweeterProfileUrl!)!)
        replyButton.setBackgroundImage(UIImage.init(named: "reply-icon"), for: UIControlState.normal)
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
        
        
    }
    @IBAction func replyButtonPressed(_ sender: Any) {

    }
    
    @IBAction func retweetButtonPressed(_ sender: Any) {
        tweet.isRetweeted = !(tweet.isRetweeted!)
        if (tweet.isRetweeted!){
            retweetButton.setBackgroundImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else {
            retweetButton.setBackgroundImage(UIImage.init(named: "retweet-icon"), for: UIControlState.normal)
        }
        TwitterClient.sharedInstance?.retweet(tweetId: tweet.tweetId!, success: { () in
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        tweet.isFavorited = !(tweet.isFavorited!)
        if(tweet.isFavorited!){
            favoriteButton.setBackgroundImage(UIImage(named: "favor-icon-1"), for: .normal)
        }
        else {
            favoriteButton.setBackgroundImage(UIImage.init(named: "favor-icon"), for: UIControlState.normal)
        }
        TwitterClient.sharedInstance?.favorite(tweetId: tweet.tweetId!, success: {
            self.favoriteButton.setImage(UIImage.init(named: "favor-icon-1"), for: UIControlState.normal)
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let replyDetailViewController = segue.destination as! ReplyDetailViewController
        replyDetailViewController.tweet = self.tweet
        
        
    }
    

}
