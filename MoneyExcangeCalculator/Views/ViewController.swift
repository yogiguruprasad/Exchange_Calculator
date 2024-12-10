//
//  ViewController.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 06/12/24.
//

import UIKit
import Toast

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var viewmodel: CurrencyViewModel = CurrencyViewModel()
    var selectedCountry: CountryModel?
    var exchangeArray = [ExchangeRate]()
    var selectedDeliveryMethod: String = "Select Delivery Method"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth - 40, height: screenWidth)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        self.exchangeArray = loadJson(filename: "json") ?? []
        viewmodel.fetchAedDetails {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    func loadJson(filename fileName: String) -> [ExchangeRate]? {
        if let url = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .alwaysMapped)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.result.data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    @objc func presentCountrySheet() {
        let sheetViewController = self.storyboard?.instantiateViewController(withIdentifier: "SheetViewController") as! SheetViewController
        sheetViewController.delegate = self
        present(sheetViewController, animated: true, completion: nil)
    }

    @objc func presentDeliverySheet() {
        let sheetViewController = DeliveryViewController()
        sheetViewController.delegate = self
        present(sheetViewController, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell: CountryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CountryCell
            cell.countryButton.setTitle(selectedCountry?.name?.common ?? "Select Country", for: .normal)
            cell.countryButton.addTarget(self, action: #selector(self.presentCountrySheet), for: .touchUpInside)
            return cell
        case 1:
            let cell: DeliveryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryCell", for: indexPath) as! DeliveryCell
            cell.deliveryButton.setTitle(selectedDeliveryMethod, for: .normal)
            cell.deliveryButton.addTarget(self, action: #selector(self.presentDeliverySheet), for: .touchUpInside)
            return cell
        case 2:
            let cell: ExchangeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeCell", for: indexPath) as! ExchangeCell
            if viewmodel.aedData.count > 0 {
                cell.configureCell(aedModel: viewmodel.aedData)
            }
            cell.configureSelectedCountry(country: selectedCountry)

            if let country = selectedCountry {
                let exchange = self.exchangeArray.filter({ $0.countryCode == country.cioc! })
                if exchange.count > 0 {
                    let exchangeRate = Double(exchange.first!.exchangeRate)! * 1000
                    cell.recipientCurrency.text = exchangeRate.description
                } else {
                    cell.recipientCurrency.text = "0.00"
                    self.view.makeToast("selected country not available for echange", duration: 3.0, position: .bottom)
                }
            }
            return cell
        default:
            let cell: PaymentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentCell", for: indexPath) as! PaymentCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 2:
            return CGSize(width: screenWidth - 40, height: 250)
        default:
            return CGSize(width: screenWidth - 40, height: 140)
        }
    }
    
}

extension ViewController: SheetViewControllerDelegate, DeliveryViewControllerDelegate {
    func didSelectCurrency(_ currency: CountryModel) {
        self.selectedCountry = currency
        self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0), IndexPath(item: 2, section: 0)])
    }
    
    func didSelectDeliveryMethod(_ value: String) {
        self.selectedDeliveryMethod = value
        self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0), IndexPath(item: 1, section: 0)])
    }
}

struct ResponseData: Decodable {
    var result: ResultData
}
struct ResultData: Decodable {
    var data: [ExchangeRate]
}
struct ExchangeRate : Decodable {
    var currencypair: String
    var countryCode: String
    var exchangeRate: String
}


