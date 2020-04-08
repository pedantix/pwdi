//
//  FactoryBuilder.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

@_functionBuilder
public struct FactoryBuilder {
  private static func convert(captures: [ServiceCapture]) -> ServiceFactories {
    return captures.map({ capture in PrototypeFactory(block: capture.1, types: capture.0) })
  }
  
  public static func buildBlock() -> ServiceFactories {
     return []
  }
  
  public static func buildBlock(_ capture: ServiceCapture) -> ServiceFactories {
     return convert(captures: [capture])
  }

  public static func buildBlock(_ captures: ServiceCapture...) -> [ServiceCapture] {
     return captures
  }
  
  public static func buildIf(_ content: ServiceCapture?) -> ServiceFactories {
    if let content = content { return convert(captures: [content]) }
    return []
  }
  
  public static func buildEither(first: ServiceCapture) -> ServiceCapture {
    return first
  }
  
  public static func buildEither(second: ServiceCapture) -> ServiceCapture {
    return second
  }
}
