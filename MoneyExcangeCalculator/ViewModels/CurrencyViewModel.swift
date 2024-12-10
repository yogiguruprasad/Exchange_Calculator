//
//  CurrencyViewModel.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

import Foundation

class CurrencyViewModel {
    private let networkClint = URLSessionNetworkClient()
    var countries: [CountryModel] = []
    var aedData: [CountryModel] = []
    weak var coordinator : AppCoordinator!

    func fetchCountries(completion: @escaping ()-> Void) {
        let endpoint = CountryEndPoint.getCountrList
        Task {
            let counties = await networkClint.request(endpoint, modelObject: [CountryModel].self, isCertificatePinning: true)
            switch counties {
            case .success(let countries):
                let items = countries.sorted(by: { (item1, item2) -> Bool in
                    return item1.name!.common.compare(item2.name!.common) == ComparisonResult.orderedAscending
                    })
                self.countries = items
                print(countries)
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func fetchAedDetails(completion: @escaping ()-> Void) {
        let endpoint = CountryEndPoint.getAedCurrency
        Task {
            let currencies = await networkClint.request(endpoint, modelObject: [CountryModel].self, isCertificatePinning: true)
            switch currencies {
            case .success(let currencies):
                print(currencies)
                self.aedData = currencies
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func goToLogin(){
        coordinator.goToLoginPage()
    }
}
