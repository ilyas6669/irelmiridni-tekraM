//
//  Json.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/4/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit


//SelectCityPop

struct WebsiteDescription : Codable {
    let count : Int
   let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name, detail: String
    let storeSet: [Int]

    enum CodingKeys: String, CodingKey {
        case id, name, detail
        case storeSet = "store_set"
    }
}


//Marketler

// MARK: - Welcome
struct Welcome: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Resultt]
}

// MARK: - Result
struct Resultt: Codable {
    let id: Int
    let name: String
    let image: Image
    let cities: [Int]
    let detail: String
}

// MARK: - Image
struct Image: Codable {
    let imageDefault, original: String

    enum CodingKeys: String, CodingKey {
        case imageDefault = "default"
        case original
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

//Urunler
// MARK: - Welcome
struct Welcomee: Codable {
    let count: Int
    let results: [Resulttt]
}

// MARK: - Result
struct Resulttt: Codable {
    let id, storeID: Int
    let name, detail: String
    let image: Image
    let price: String?
    let pricePrefixText, priceSuffixText, offerText: String
    let validDates: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case storeID = "store_id"
        case name, detail, image, price
        case pricePrefixText = "price_prefix_text"
        case priceSuffixText = "price_suffix_text"
        case offerText = "offer_text"
        case validDates = "valid_dates"
    }
}


// MARK: - Banner
struct Banner: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Resullt]
}

// MARK: - Result
struct Resullt: Codable {
    let id: Int
    let title, subtitle, linkURL: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle
        case linkURL = "link_url"
        case image
    }
}


// MARK: - SingleStore
struct SingleStore: Codable {
    let id: Int
    let name: String
    let image: Image
    let cities: [Int]
    let detail: String
}

// MARK: - SingleProduct
struct SingleProduct: Codable {
    let id, storeID: Int
    var name, detail: String
    let image: Image
    let price, pricePrefixText, priceSuffixText, offerText: String? //bura qoy olrukii gorumm bu olur
    let validDates: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case storeID = "store_id"
        case name, detail, image, price
        case pricePrefixText = "price_prefix_text"
        case priceSuffixText = "price_suffix_text"
        case offerText = "offer_text"
        case validDates = "valid_dates"
    }
}

// MARK: - SingleMarket
struct SingleMarket: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Market]
}

// MARK: - Result
struct Market: Codable {
    let id: Int
    let name: String
    let image: Image
    let cities: [Int]
    let detail: String
}


// bi de tema bisen nedi nie marketi secende deyismirdi cunki tab bara basanda deyisir ordada cixib geri qayidirsan deye deyismirdi he tapdm ozum gozde indi erroru cixar da bilsey zor tema bisen nedi ana seyfeni deyismisem men qaytarm evvelkine? niye deyismisenki `/ duzdeeldtim belke coxntrindiydide duzeltmisen ana seyfeni `/ deirdim`k/i bidene atm app store sen bax gor geovde tegl ozyoxdu indi gozde simulatorden baxim 

