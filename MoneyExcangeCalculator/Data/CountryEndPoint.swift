//
//  CountryEndPoint.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

import Foundation

enum CountryEndPoint {
    case getCountrList
    case getAedCurrency
}

extension CountryEndPoint: Endpoint {
    var baseURL: URL {
        return URL(string: "https://restcountries.com/v3.1")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCountrList:
            return ["status":true,
                    "fields":"cca2,cca3,ccn3,cioc,flags,currencies"
            ]
        case .getAedCurrency:
            return nil
        }
        
    }
    
    var path: String {
        switch self {
        case .getCountrList:
            return "/independent"
            case .getAedCurrency:
            return "/currency/aed"
        }
    }
}
