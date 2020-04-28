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

  var suggestedFixes: [String]

  private init(
    identifier: String,
    reason: String,
    sourceLocation: SourceLocation,
    suggestedFixes: [String] = [],
    stackTrace: [String] = Thread.callStackSymbols
  ) {
    self.stackTrace = stackTrace
    self.reason = reason
    self.identifier = identifier
    self.sourceLocation = sourceLocation
    self.suggestedFixes = suggestedFixes
  }

  internal static func noServiceFound(
    reason: String = "The container was unable to find a service matching the supplied type",
    stackTrace: [String] = Thread.callStackSymbols.dropLast(),
    sourceLocation: SourceLocation = .capture()
  ) -> ServiceError {
    return .init(identifier: "No Service Found", reason: reason, sourceLocation: sourceLocation)
  }

  internal static func duplicateServicesFound(
     reason: String = "The container found multiple services matching the suplied type",
     stackTrace: [String] = Thread.callStackSymbols.dropLast(),
     sourceLocation: SourceLocation = .capture()
   ) -> ServiceError {
     return .init(
      identifier: "Duplicate Services Found",
      reason: reason,
      sourceLocation: sourceLocation,
      suggestedFixes: ["Try using a qualifier to disambuate"]
    )
   }

  internal static func registrationError(
    type: Any.Type,
    reason: String = "The container found a registered service however it failed to be cast to the requested type",
    stackTrace: [String] = Thread.callStackSymbols.dropLast(),
    sourceLocation: SourceLocation = .capture()
  ) -> ServiceError {
    return .init(
      identifier: "Registration Error: Type Cast Failure",
      reason: reason,
      sourceLocation: sourceLocation,
      suggestedFixes: ["Check that registered `Service` for \(type) type supplies objects that conform to this" +
        " protocol or are this type"]
    )
  }
}
