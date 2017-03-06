//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 3/4/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var tweeterScreennameLabel: UILabel!
    @IBOutlet weak var tweeterNameLabel: UILabel!
    @IBOutlet weak var numOfTweetsLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    
    var tweetUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = tweetUser
        tweeterNameLabel.text = user?.name
        tweeterScreennameLabel.text = "@\((user?.screenname)!)"
        numOfTweetsLabel.text = String(describing: user!.numOfTweets!)
        numFollowersLabel.text = String(describing: user!.numFollowers!)
        numFollowingLabel.text = String(describing: user!.numFollowing!)
        profilePictureImageView.setImageWith((user?.profileUrl!)!)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
