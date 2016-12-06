//
//  Parser.swift
//  JSONAPI
//
//  Created by Skylar Schipper on 12/5/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

public final class Parser {
    static let data = "data"
    static let attributes = "attributes"
    static let relationships = "relationships"
    static let id = "id"
    static let type = "type"

    enum ParserError : Error {
        case unknownError
        case unexpectedRoot
        case missingObjectForKey(String)
    }

    public class func parse(object: Any) throws -> Resource {
        guard let root = object as? [String: Any] else {
            throw ParserError.unexpectedRoot
        }
        guard let data = root[Parser.data] as? [String: Any] else {
            throw ParserError.missingObjectForKey(Parser.data)
        }
        return try self.createResource(object: data)
    }

    public class func parse(objects: Any) throws -> [Resource] {
        throw ParserError.unknownError
    }

    // MARK: - Helpers
    private class func createResource(object: [String: Any]) throws -> Resource {
        guard let id = object[Parser.id] as? String else {
            throw ParserError.missingObjectForKey(Parser.id)
        }
        guard let type = object[Parser.type] as? String else {
            throw ParserError.missingObjectForKey(Parser.type)
        }
        guard let attributes = object[Parser.attributes] as? [String: Any] else {
            throw ParserError.missingObjectForKey(Parser.attributes)
        }
        guard let relationships = object[Parser.relationships] as? [String: Any] else {
            throw ParserError.missingObjectForKey(Parser.relationships)
        }
        let realAttributes = try self.createAttributes(hash: attributes)
        let realRelationships = try self.createRelationships(hash: relationships)
        return Resource(id, type, realAttributes, realRelationships)
    }

    private class func createAttributes(hash: [String: Any]) throws -> [String: Attribute] {
        var attributes: [String: Attribute] = [:]
        hash.forEach() { (key, value) in
            attributes[key] = Attribute(value)
        }
        return attributes
    }

    private class func createRelationships(hash: [String: Any]) throws -> [String: Relationship] {
        var relationships: [String: Relationship] = [:]
        try hash.forEach() { (key, value) in
            relationships[key] = try Relationship(value)
        }
        return relationships
    }
}
