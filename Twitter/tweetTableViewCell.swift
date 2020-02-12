//
//  tweetTableViewCell.swift
//  Twitter
//
//  Created by Heart on 2/2/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class tweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var faved: Bool = false
    var tweetID: Int = -1
    var retweeted: Bool = false
    
    @IBAction func favorite(_ sender: Any) {
        let toFav = !faved
        if (toFav){
            TwitterAPICaller.client?.FavTweets(tweetID: tweetID, success: {
                self.setFav(true)
            }, failure: { (Error) in
                print("Couldn't favorite due to \(Error)")
            })
        } else{
            TwitterAPICaller.client?.UnFavTweets(tweetID: tweetID, success: {
                self.setFav(false)
            }, failure: { (Error) in
                print("Couldn't unfavorite due to \(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetID: tweetID, success: {
            self.setRetweet(true)
        }, failure: { (Error) in
            print("couldn't retweet due to \(Error)")
        })
    }
    
    
    func setRetweet(_ isRetweeted: Bool) {
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setFav(_ isFav: Bool) {
        faved = isFav
        if (faved){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
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
