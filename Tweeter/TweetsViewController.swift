//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 2/26/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegator {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.tweets != nil){
            return self.tweets.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath as IndexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        cell.retweetButton.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        //cell.delegate = self
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callSegueFromCell(user: User){
        self.performSegue(withIdentifier: "profileSeguefromCell", sender: user)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "tweetDetailSegue"){
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let tweetDetailViewController = segue.destination as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        }
        if (segue.identifier == "profileSeguefromMe"){
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.tweetUser = User.currentUser
        }
        if (segue.identifier == "profileSeguefromCell") {
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.tweetUser = sender as! User
        }

        
        
    }
    

}
