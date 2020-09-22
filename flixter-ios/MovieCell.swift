//
//  MovieCell.swift
//  flixter-ios
//
//  Created by Sara Kazemi on 9/22/20.
//

import UIKit

class MovieCell: UITableViewCell {
    // outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
