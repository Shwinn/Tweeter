//
//  ComposeViewController.swift
//  Tweeter
//
//  Created by Ashwin Gupta on 3/5/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var composeTweetTextView: UITextView!
    @IBOutlet weak var composeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func composeButtonPressed(_ sender: Any) {
        let params = NSDictionary(dictionary: ["status" : composeTweetTextView.text!])
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
