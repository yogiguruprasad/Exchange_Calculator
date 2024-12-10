//
//  NetworkError.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 06/12/24.
//

import Foundation

enum NetworkError: Error {
 case invalidRequest
 case networkError(Error)
 case noData
 case decodingError(Error)
}
