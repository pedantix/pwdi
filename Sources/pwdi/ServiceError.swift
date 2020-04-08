//
//  ServiceError.swift
//  
//
//  Created by Shaun Hubbard on 4/7/20.
//

import Foundation
import FregaderoDeCocina

class ServiceError: Debuggable {
    var identifier: String
    
    var reason: String
    
    var sourceLocation: SourceLocation
    
    var stackTrace: [String]?
    
    var suggestedFixes: [String] = []
    
    private init(identifier: String, reason: String, sourceLocation: SourceLocation, stackTrace: [String] = Thread.callStackSymbols ) {
        self.stackTrace = stackTrace
        self.reason = reason
        self.identifier = identifier
        self.sourceLocation = sourceLocation
    }
    
    internal static func noServiceFound(
        reason: String = "The container was unable to find a service matching the supplied type",
        stackTrace: [String] = Thread.callStackSymbols.dropLast(), sourceLocation: SourceLocation = .capture()) -> ServiceError  {
        return .init(identifier: "No Service Found", reason: reason, sourceLocation: sourceLocation)
    }
}
