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

  public init(@ServiceBuilder builder: () -> [Service]) {
    factories = builder().map { service in  PrototypeFactory(service: service) }
  }
}
