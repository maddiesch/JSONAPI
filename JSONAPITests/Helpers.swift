//
//  Helpers.swift
//  JSONAPI
//
//  Created by Skylar Schipper on 12/5/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

func test_file(_ name: String) -> Any {
    guard let url = Bundle(for: JSONAPITests.self).url(forResource: name, withExtension: "json") else {
        fatalError()
    }
    let data = try! Data(contentsOf: url)
    return try! JSONSerialization.jsonObject(with: data, options: [])
}
