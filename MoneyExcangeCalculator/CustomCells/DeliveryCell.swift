//
//  DeliveryCell.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

import UIKit

class DeliveryCell: UICollectionViewCell {
    @IBOutlet weak var deliveryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deliveryButton.layer.cornerRadius = 10
        deliveryButton.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
