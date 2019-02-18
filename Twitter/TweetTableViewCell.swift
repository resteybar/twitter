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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
