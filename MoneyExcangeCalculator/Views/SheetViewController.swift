//
//  SheetViewController.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

import UIKit
import SkeletonView

protocol SheetViewControllerDelegate: AnyObject {
    func didSelectCurrency(_ currency: CountryModel)
}

class SheetViewController: UIViewController {
    var delegate: SheetViewControllerDelegate?
    var viewmodel: CurrencyViewModel = CurrencyViewModel()
    // Lazy initialization of the UICollectionView
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var searchTextfield: UITextField!
    var isSearchEnabled = false
    var searchedCountryArray = [CountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        mainCollectionView.collectionViewLayout = flowLayout
        mainCollectionView.startSkeletonAnimation()
        viewmodel.fetchCountries() {
            self.reloadCollectionView()
        }
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium()
            ]
            presentationController.preferredCornerRadius = 20
        }
        
    }
    
    // Method to reload the collection view on the main thread
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.stopSkeletonAnimation()
            self?.mainCollectionView.reloadData()
        }
    }

}

extension SheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
}

// MARK: - SkeletonCollectionViewDataSource

extension SheetViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CountryCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as? CountryCollectionViewCell
        cell?.isSkeletonable = indexPath.row != 0
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
            let cell = cell as? CountryCollectionViewCell
            cell?.isSkeletonable = indexPath.row != 0
    }
    
    // Return the number of items in the collection view section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchEnabled {
            return searchedCountryArray.count
        }
        return viewmodel.countries.count
    }
    
    // Configure and return the cell for a given index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as! CountryCollectionViewCell
        if isSearchEnabled {
            cell.configure(with: searchedCountryArray[indexPath.row])
        } else {
            cell.configure(with: viewmodel.countries[indexPath.row])
        }
        return cell
    }
    
    // Return the size for the item at a given index path
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = mainCollectionView.frame.width - 20
        return CGSize(width: size, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectCurrency(viewmodel.countries[indexPath.row])
        self.dismiss(animated: true)
    }
}

extension SheetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            self.isSearchEnabled = false
        } else {
            self.isSearchEnabled = true
        }
        self.searchedCountryArray = self.viewmodel.countries.filter({ country in
            return country.name?.official.contains(string) ?? false
        })
        self.mainCollectionView.reloadData()
        return true
    }
}
