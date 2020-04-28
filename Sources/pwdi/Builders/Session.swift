//
//  File.swift
//  
//
//  Created by Shaun Hubbard on 4/23/20.
//

import Foundation

/// Build Singleton dependencies using the Service struct
public struct Session: FactoryProducer {
  public let factories: ServiceFactories

  // This is ugly, FactoryBuilder should be able to do this
  public init(@ServiceBuilder _ content: () -> Service) {
    factories = [content()].map { service in  SessionFactory(service: service) }
  }

  public init(@ServiceBuilder _ content: () -> [Service]) {
    factories = content().map { service in  SessionFactory(service: service) }
  }
}
