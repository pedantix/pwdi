//
//  serviceBuilder.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

///https://www.andyibanez.com/posts/understanding-function-builders/
// use the above as a guid for writing captures
// TODO: This wont work as functions, the sytax is insufficently clean
public typealias ServiceCapture = (types: [Any.Type], block: ServiceClosure)
public typealias ServiceClosure = (Container) throws -> Service

/// A building block to create services
public func service<S: Service>(_ service: S.Type, _ block: @escaping (Container) throws -> S) -> ServiceCapture {
    return ([S.self], block)
}

/// A building block to create services
public func service<S: Service>(_ block: @escaping (Container) throws -> S) -> ServiceCapture {
    return ([S.self], block)
}

// NOTE: Theres an assumption here that types are all conformed to by S
// at runtime the container will throw an error which will lead to a
// preconditionFailure in annotations if this type is called but the conformance fails.
// TODO: Test the above note
/// A building block to create services
public func service<S: Service>(_ types: [Any.Type], _ block: @escaping (Container) throws -> S) -> ServiceCapture {
  return (types, block)
}
