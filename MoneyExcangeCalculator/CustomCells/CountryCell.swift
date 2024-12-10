//
//  CountryCell.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

import UIKit

class CountryCell: UICollectionViewCell {
    @IBOutlet weak var countryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryButton.layer.cornerRadius = 10
        countryButton.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
