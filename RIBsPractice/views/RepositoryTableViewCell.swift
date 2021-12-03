//
//  RepositoryTableViewCell.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/02.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var favoriteMarkView: UIView!
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        
        descriptionLabel.text = nil
        fullNameLabel.text = nil
        
        favoriteMarkView.backgroundColor = UIColor.clear
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(_ repository: Repository, isFavorite: Bool) {
        
        ImageLoader.getImage(from: repository.ownerAvatarUrl) { [weak self] (image) in
            self?.avatarImageView.image = image
        }
        self.fullNameLabel.text = repository.fullName
        self.descriptionLabel.text = repository.name
        
        self.favoriteMarkView.backgroundColor = isFavorite ? UIColor.blue : UIColor.clear
    }
    
    func updateFavorite(_ mark: Bool) {
        self.favoriteMarkView.backgroundColor = mark ? UIColor.blue : UIColor.clear
    }
    
}


