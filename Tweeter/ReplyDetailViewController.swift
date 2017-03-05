//
//  ReplyDetailViewController.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 3/4/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class ReplyDetailViewController: UIViewController {

    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var replyButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTextView.text = "@\(tweet.tweeterUsername!)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ReplyButtonPressed(_ sender: Any) {
        let params = NSDictionary(dictionary: ["status" : replyTextView.text!, "in_reply_to_status_id": tweet.tweetId!])
        TwitterClient.sharedInstance?.reply(params: params, success: {
            print("Succesfully retweeted")
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        self.navigationController?.popViewController(animated: true)
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
