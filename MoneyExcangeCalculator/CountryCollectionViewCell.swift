//
//  CountryCollectionViewCell.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 08/12/24.
//

import UIKit
import SkeletonView

class CountryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CountryCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        isSkeletonable = true
        imageView.isSkeletonable = true
        nameLabel.isSkeletonable = true
    }

    
    // Configure the cell with the image name
    func configure(with imageName: CountryModel) {
        imageView.downloaded(from: imageName.flags?.png ?? "")
        nameLabel.text = imageName.name?.common ?? ""
    }

}
