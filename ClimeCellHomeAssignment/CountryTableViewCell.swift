//
//  CountryTableViewCell.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 20/11/2020.
//

import UIKit
//import SDWebImage

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryAndCapitalName: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel : CountryViewModel) {
        self.countryAndCapitalName.text = viewModel.description
        guard let imageUrl = viewModel.flagImageUrl else {
            return
        }
        self.flagImageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: [], context: [.imageThumbnailPixelSize : CGSize(width: 500, height: 500)])
    }
    
}
