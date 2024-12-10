//
//  PaymentCell.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

import UIKit

class PaymentCell: UICollectionViewCell {
    @IBOutlet weak var paymentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        paymentButton.layer.cornerRadius = 10
        paymentButton.clipsToBounds = true
    }
}
