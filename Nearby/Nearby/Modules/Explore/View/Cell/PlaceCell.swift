//
//  MovieSearchCell.swift
//  Movielix
//
//  Created by Mustafa Ezzat on 5/7/20.
//  Copyright © 2020 Swvl. All rights reserved.
//

import UIKit
import Nuke

class PlaceCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var placePhoto: UIImageView!
    @IBOutlet weak var containerView: RoundedShadowView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configure(_ place: Place) {
        nameLabel.text = place.name
        nameLabel.font = UIFont(fontStyle: .SFProDisplayBold, size: 20)
        addressLabel.text = place.address
        addressLabel.font = UIFont(fontStyle: .SFProDisplayRegular, size: 13)
        handleColorMode()
        downloadPhoto(place.photo)
    }
    func handleColorMode() {
        nameLabel.textColor = .primary
        addressLabel.textColor = .primary
        containerView.backgroundColor = .secondary
    }
    func downloadPhoto(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "logo"),
            transition: .fadeIn(duration: 0.33),
            failureImage: UIImage(named: "logo"),
            contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFit, placeholder: .scaleAspectFit)
        )
        Nuke.loadImage(with: url, options: options, into: placePhoto)
    }
}
