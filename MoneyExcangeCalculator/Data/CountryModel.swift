//
//  CountryModel.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 07/12/24.
//

struct CountryModel: Decodable {
    let flags: Flags?
    let name: Name?
    let cca2: String
    let cioc: String?
    let cca3: String
    let ccn3: String
    let currencies: [String: Currency]
//    let capital: [String]
//    let language: Languages?
}

struct Name: Codable {
    let common: String
    let official: String
    let nativeName: [String: NativeName]
}

struct NativeName: Codable {
    let official: String
    let common: String
}
struct Currency: Codable {
    let name: String
    let symbol: String
}

struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String
}

struct Languages: Codable {
    let eng: String
}
