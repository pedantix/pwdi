//
//  PrototypeBuilder.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

public typealias ServiceFactories = [ServiceFactory]

typealias FactoryProducers = [FactoryProducer]

///  Can this not be public?
protocol FactoryProducer {
    var factories: ServiceFactories { get }
}

/// Build Prototype dependencies using the serviceBuilder functions
public struct Prototype: FactoryProducer {
  public let factories: ServiceFactories

  // This is ugly, PrototypeBuilder should be able to do this
  public init(@FactoryBuilder _ content: () -> Service) {
    factories = [content()].map { service in  PrototypeFactory(service: service) }
  }

  public init(@FactoryBuilder _ content: () -> [Service]) {
    factories = content().map { service in  PrototypeFactory(service: service) }
  }
}
