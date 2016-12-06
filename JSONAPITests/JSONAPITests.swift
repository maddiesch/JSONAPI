//
//  JSONAPITests.swift
//  JSONAPITests
//
//  Created by Skylar Schipper on 12/5/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import XCTest
@testable import JSONAPI

class JSONAPITests: XCTestCase {
    func testSingleResource() {
        let data = test_file("Person")
        do {
            let person = try Parser.parse(object: data)
            XCTAssertEqual(person.id, "12345")
            XCTAssertEqual(person.type, "Person")
        } catch let e {
            XCTFail("Error: \(e)")
        }
    }

    func testAttributes() {
        let data = test_file("Person")
        do {
            let person = try Parser.parse(object: data)
            let attrs = person.attributes
            XCTAssertEqual(attrs["first_name"]?.string, "Skylar")
            XCTAssertEqual(attrs["last_name"]?.string, "Schipper")
        } catch let e {
            XCTFail("Error: \(e)")
        }
    }

    func testRelationships() {
        let data = test_file("Person")
        do {
            let person = try Parser.parse(object: data)
            let rel = person.relationships
            XCTAssertEqual(rel["created_by"]?.id, "35")
        } catch let e {
            XCTFail("Error: \(e)")
        }
    }
}
