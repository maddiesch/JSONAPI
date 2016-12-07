//
//  Relationship.swift
//  JSONAPI
//
//  Created by Skylar Schipper on 12/5/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

public enum Relationship {
    public struct Info {
        public let id: String
        public let type: String

        init(_ raw: [String: String]) throws {
            guard let id = raw[Parser.id] else {
                throw Parser.ParserError.missingObjectForKey(Parser.id)
            }
            guard let type = raw[Parser.type] else {
                throw Parser.ParserError.missingObjectForKey(Parser.type)
            }
            self.id = id
            self.type = type
        }
    }

    case multi([Info])
    case single(Info)
    case null

    public var singleID: String? {
        switch self {
        case .single(let info):
            return info.id
        default:
            return nil
        }
    }

    public var multipleIDs: [String]? {
        switch self {
        case .multi(let infos):
            return infos.map() { $0.id }
        default:
            return nil
        }
    }
}

internal func relationshipBuilder(_ raw: Any) throws -> Relationship {
    guard let root = raw as? [String: Any] else {
        throw Parser.ParserError.unexpectedRoot
    }

    if let single = root[Parser.data] as? [String: String] {
        let info = try Relationship.Info(single)
        return Relationship.single(info)
    } else if let multi = root[Parser.data] as? [[String: String]] {
        var infos: [Relationship.Info] = []
        try multi.forEach() {
            let info = try Relationship.Info($0)
            infos.append(info)
        }
        return Relationship.multi(infos)
    } else if root[Parser.data] is NSNull {
        return Relationship.null
    } else {
        throw Parser.ParserError.missingObjectForKey(Parser.data)
    }
}
