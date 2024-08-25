//
//  CountryService.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import Foundation

struct CountryService {
    func getCountries() -> [Country] {
        let countryCodes = [
            "rs", "dk", "us", "br", "cz", "fr", "no", "id", "cl", "si",
            "it", "is", "za", "hk", "hr", "de", "fi", "es", "vn", "nl",
            "ua", "co", "ru", "au", "ec", "pl", "in", "my", "pa", "ro",
            "ca", "sk", "pt", "lt", "jp", "mk", "ph", "tr", "ar", "ee",
            "ch", "th", "se", "at", "nz", "sg", "be", "gb", "md", "az",
            "cy", "kr", "ie", "mx", "pe", "ae", "gr", "il", "bg", "hu"
        ]
        
        var countryList = [Country]()
        
        for code in countryCodes {
            let name = Locale.current.localizedString(forRegionCode: code.uppercased()) ?? "Unknown"
            let emoji = CountryService.getEmoji(for: code)
            countryList.append(Country(code: code, name: name, emoji: emoji))
        }
        
        countryList.sort { $0.name < $1.name }

        return countryList
    }
    
    static func getEmoji(for countryCode: String) -> String {
        let base: UInt32 = 127397
        var emoji = ""
        for scalar in countryCode.uppercased().unicodeScalars {
            emoji.unicodeScalars.append(UnicodeScalar(base + scalar.value)!)
        }
        return emoji
    }
}
