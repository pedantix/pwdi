//
//  PrototypeBuilder.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

public typealias ServiceFactories = [ServiceFactory]

public typealias FactoryProducers = [FactoryProducer]

///  Can this not be public?
public protocol FactoryProducer {
    var factories: ServiceFactories { get }
}

/// Build Prototype dependencies using the serviceBuilder functions
public struct Prototype: FactoryProducer {
  public let factories: ServiceFactories

  // This is ugly, PrototypeBuilder should be able to do this
  public init(@FactoryBuilder _ content: () -> ServiceCapture) {
    factories = [content()].map { capture in  PrototypeFactory(block: capture.1, types: capture.0) }
  }

  public init(@FactoryBuilder _ content: () -> [ServiceCapture]) {
    factories = content().map { capture in PrototypeFactory(block: capture.1, types: capture.0) }
  }
}
