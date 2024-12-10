//
//  ExchangeCell.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

import UIKit

class ExchangeCell: UICollectionViewCell {
    @IBOutlet weak var depositView: UIView!
    @IBOutlet weak var recipientView: UIView!
    @IBOutlet weak var depositImage: UIImageView!
    @IBOutlet weak var recipientImage: UIImageView!
    @IBOutlet weak var depositCountry: UILabel!
    @IBOutlet weak var recipientCountry: UILabel!
    @IBOutlet weak var depositCurrency: UILabel!
    @IBOutlet weak var recipientCurrency: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        depositView.layer.cornerRadius = 10
        depositView.layer.borderColor = UIColor.lightGray.cgColor
        depositView.layer.borderWidth = 0.5
        
        recipientView.layer.cornerRadius = 10
        recipientView.layer.borderColor = UIColor.lightGray.cgColor
        recipientView.layer.borderWidth = 0.5
        
        depositImage.layer.cornerRadius = 15
        depositImage.clipsToBounds = true
        
        recipientImage.layer.cornerRadius = 15
        recipientImage.clipsToBounds = true
    }
    
    func configureCell(aedModel:[CountryModel]) {
        if aedModel.count > 0 {
            if let aedModel = aedModel[0].flags?.png {
                self.depositImage.downloaded(from: aedModel)
            }
            self.depositCountry.text = aedModel[0].currencies.keys.first
            self.depositCurrency.text = "1000.00"
        }
    }
    
    func configureSelectedCountry(country: CountryModel?) {
        if let country = country {
            if let aedModel = country.flags?.png {
                self.recipientImage.downloaded(from: aedModel)
            }
            self.recipientCountry.text = country.currencies.keys.first
        }
    }
}
