//
//  Relationship.swift
//  JSONAPI
//
//  Created by Skylar Schipper on 12/5/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

public struct Relationship {
    let id: String
    let type: String

    init(_ raw: Any) throws {
        guard let data = raw as? [String: Any] else {
            throw Parser.ParserError.unexpectedRoot
        }
        guard let hash = data[Parser.data] as? [String: String] else {
            throw Parser.ParserError.missingObjectForKey(Parser.data)
        }
        guard let id = hash[Parser.id] else {
            throw Parser.ParserError.missingObjectForKey(Parser.id)
        }
        guard let type = hash[Parser.type] else {
            throw Parser.ParserError.missingObjectForKey(Parser.type)
        }
        self.id = id
        self.type = type
    }
}
