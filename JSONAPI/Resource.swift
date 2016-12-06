//
//  Resource.swift
//  JSONAPI
//
//  Created by Skylar Schipper on 12/5/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

public struct Resource {
    public let id: String
    public let type: String
    public let attributes: [String: Attribute]
    public let relationships: [String: Relationship]

    init(_ id: String, _ type: String, _ attributes: [String: Attribute], _ relationships: [String: Relationship]) {
        self.id = id
        self.type = type
        self.attributes = attributes
        self.relationships = relationships
    }
}
