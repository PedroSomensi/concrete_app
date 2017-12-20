//
//  PullRequestTableViewCell.swift
//  desafio-ios
//
//  Created by Pedro on 03/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import UIKit
import SDWebImage

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var tittlePullRequest: UILabel!
    @IBOutlet weak var descriptionPullRequest: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name_owner: UILabel!
    @IBOutlet weak var image_owner: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setup(pullrequest: PullRequest){
        self.tittlePullRequest.text = pullrequest.info_PR?.title_pr
        self.descriptionPullRequest.text = pullrequest.info_PR?.body_pr
        self.username.text = pullrequest.user_PR?.name_user
        self.name_owner.text = pullrequest.repository?.name_repository
        guard let dateString = pullrequest.info_PR?.data_pr else { return }
        self.date.text = convertDate(str: dateString)
        
        self.image_owner.round()
        self.image_owner.sd_setImage(with: URL(string: (pullrequest.user_PR?.image_user)!), placeholderImage: UIImage(named: "Unknown"), options: [.progressiveDownload, .continueInBackground], completed: nil)
    }
    
    
    
}
