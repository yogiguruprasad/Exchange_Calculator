//
//  DeliverySelectionCell.swift
//  MoneyExcangeCalculator
//
//  Created by johnson veerlapally on 09/12/24.
//

import UIKit

class DeliverySelectionCell: UICollectionViewCell {
    static let identifier = "DeliverySelectionCell"

    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(value: String) {
        nameLabel.text = value
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        imageView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 5).isActive = true
        imageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
