//
//  FavoriteRepoTableViewCell.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/03.
//

import UIKit

class FavoriteRepoTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoFullName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        repoName.text = nil
        repoFullName.text = nil
        descriptionLabel.text = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func udpateUI(_ repository: Repository) {
        ImageLoader.getImage(from: repository.ownerAvatarUrl) { [weak self] (image) in
            self?.avatarImage.image = image
        }
        
        repoName.text = repository.name
        repoFullName.text = repository.fullName
        descriptionLabel.text = repository.language
    }
    
}
