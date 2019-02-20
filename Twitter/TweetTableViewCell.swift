//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Raymond Esteybar on 2/17/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profile_image_view: UIImageView!
    @IBOutlet weak var user_name_label: UILabel!
    @IBOutlet weak var tweet_content: UILabel!
    @IBOutlet weak var fav_button: UIButton!
    @IBOutlet weak var retweet_button: UIButton!
    
    var favorited: Bool = false
    var tweetId: Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let to_be_favorited = !favorited    // If the user favorited the tweet already, turn it off
        
        if (to_be_favorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.set_favorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.set_favorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.set_retweeted(true)
        }, failure: { (Error) in
            print("Error in retweeting: \(Error)")
        })
    }
    
    func set_favorite(_ is_favorited: Bool) {
        favorited = is_favorited
        if (favorited) {
            fav_button.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            fav_button.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func set_retweeted(_ is_retweeted: Bool) {
        if (is_retweeted) {
            retweet_button.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet_button.isEnabled = false    // Makes sure nothing happens after pressing it
        } else {
            retweet_button.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet_button.isEnabled = true
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
