//
//  PrototypeBuilder.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

/// Build Prototype dependencies using the Service struct
public struct Prototype: FactoryProducer {
  public let factories: ServiceFactories

  // This is ugly, FactoryBuilder should be able to do this
  public init(@FactoryBuilder _ content: () -> Service) {
    factories = [content()].map { service in  PrototypeFactory(service: service) }
  }

  public init(@FactoryBuilder _ content: () -> [Service]) {
    factories = content().map { service in  PrototypeFactory(service: service) }
  }
}
