//
//  Attribute.swift
//  JSONAPI
//
//  Created by Skylar Schipper on 12/5/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

public enum Attribute {
    case null
    case string(String)
    case integer(Int)
    case float(Float)
    case unknown(Any)

    public var string: String? {
        switch self {
        case .string(let v):
            return v
        default:
            return nil
        }
    }

    public var integer: Int? {
        switch self {
        case .integer(let v):
            return v
        default:
            return nil
        }
    }

    public var float: Float? {
        switch self {
        case .float(let v):
            return v
        default:
            return nil
        }
    }

    public var value: Any? {
        switch self {
        case .null:
            return nil
        case .string(let v):
            return v
        case .unknown(let v):
            return v
        case .float(let v):
            return v
        case .integer(let v):
            return v
        }
    }

    public var iso8601Date: Date? {
        switch self {
        case .string(let string):
            return ISO8601Date(from: string)
        default:
            return nil
        }
    }

    public var iso8601DateTime: Date? {
        switch self {
        case .string(let string):
            return ISO8601DateTime(from: string)
        default:
            return nil
        }
    }

    init(_ raw: Any) {
        switch raw {
        case is NSNull:
            self = .null
        case is String:
            self = .string(raw as! String)
        case is Int:
            self = .integer(raw as! Int)
        case is Float:
            self = .float(raw as! Float)
        default:
            self = .unknown(raw)
        }
    }
}

fileprivate func ISO8601Date(from string: String) -> Date? {
    let fmt = DateFormatter()
    fmt.timeZone = TimeZone(identifier: "UTC")
    fmt.locale = Locale(identifier: "en_US_POSIX")
    fmt.dateFormat = "yyyy-MM-dd";
    return fmt.date(from: string)
}

fileprivate func ISO8601DateTime(from string: String) -> Date? {
    let fmt = DateFormatter()
    fmt.timeZone = TimeZone(identifier: "UTC")
    fmt.locale = Locale(identifier: "en_US_POSIX")
    fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return fmt.date(from: string)
}
