//
//  UserTableViewCell.swift
//  desafio-ios
//
//  Created by Pedro on 02/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var name_repository: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var description_repository: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name_owner: UILabel!
    @IBOutlet weak var image_owner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(user : User) {
        self.name_repository.text = user.userGitHub?.name_repository
        self.description_repository.text = user.userGitHub?.description_repository
        self.forks.text = user.userGitHub?.forks?.description
        self.stars.text = user.userGitHub?.stars?.description
        self.username.text = user.ownerRepo?.name
        self.name_owner.text = user.userGitHub?.full_name
        
        self.image_owner.round()
        self.image_owner.sd_setImage(with: URL(string: (user.ownerRepo?.avatar_url)!), placeholderImage: UIImage(named: "Unknown"), options: [.progressiveDownload, .continueInBackground], completed: nil)
    }

}
