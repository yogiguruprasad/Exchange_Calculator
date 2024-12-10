//
//  DeliveryViewController.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 08/12/24.
//

import UIKit

protocol DeliveryViewControllerDelegate: AnyObject {
    func didSelectDeliveryMethod(_ value: String)
}

class DeliveryViewController: UIViewController {
    private let myArray: [String] = ["Bank Account","Cash Pickuph","Mobile Wallet"]
    var delegate: DeliveryViewControllerDelegate?
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(DeliverySelectionCell.self, forCellWithReuseIdentifier: DeliverySelectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 254, green: 254, blue: 254, alpha: 1.0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        let titleLable = UILabel(frame: CGRect(x: 10, y: 10, width: displayWidth - 20, height: 21))
        titleLable.text = "Select delivery method"
        titleLable.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLable.textColor = .black
        self.view.addSubview(titleLable)
        
        mainCollectionView.frame = CGRect(x: 10, y: 40, width: displayWidth - 20, height: displayHeight - 40)
        self.view.addSubview(mainCollectionView)
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            presentationController.preferredCornerRadius = 20
        }
        
    }
}

extension DeliveryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliverySelectionCell", for: indexPath) as! DeliverySelectionCell
        cell.setValues(value: myArray[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.3
        if cell.isSelected {
            cell.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            cell.layer.borderColor = UIColor.lightGray.cgColor
        }
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DeliverySelectionCell
        cell.isSelected = !cell.isSelected
        self.delegate?.didSelectDeliveryMethod(myArray[indexPath.row])
        self.dismiss(animated: true)
    }
    
    
}

extension DeliveryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 40)
    }
}
