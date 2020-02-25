//
//  SchoolModel.swift
//  MapKit-Introduction-Lab
//
//  Created by Liubov Kaper  on 2/25/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct SchoolData: Codable {
    let school_name: String
    let website: String
    let location: String
    let latitude: String
    let longitude: String
}

extension SchoolData {
    static func getSschools() -> [SchoolData] {
        var schools = [SchoolData]()
        guard let fileURL = Bundle.main.url(forResource: "school", withExtension: "json") else {
            fatalError("could not locate json")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let schoolData = try JSONDecoder().decode([SchoolData].self, from: data)
            schools = schoolData
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return schools
    }
}
