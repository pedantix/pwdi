//
//  ServiceBuilder.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

@resultBuilder
public struct ServiceBuilder {
  private static func convert(services: [Service]) -> ServiceFactories {
    return services.map({ service in PrototypeFactory(service: service) })
  }

  public static func buildBlock() -> ServiceFactories {
     return []
  }

  public static func buildBlock(_ captures: Service...) -> [Service] {
     return captures
  }

  public static func buildIf(_ content: Service?) -> ServiceFactories {
    if let content = content { return convert(services: [content]) }
    return []
  }

  public static func buildEither(first: Service) -> Service {
    return first
  }

  public static func buildEither(second: Service) -> Service {
    return second
  }
}
