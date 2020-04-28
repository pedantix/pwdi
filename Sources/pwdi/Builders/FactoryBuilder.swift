//
//  FactoryBuilder.swift
//  
//
//  Created by Shaun Hubbard on 4/28/20.
//

import Foundation

public enum FactoryNode {
  case factoryNode(FactoryProducer)
  case nodes([FactoryNode])
  case empty

  var factories: ServiceFactories {
    switch self {
    case let .factoryNode(factoryProducer):
      return factoryProducer.factories
    case let .nodes(nodes):
      return nodes.flatMap { $0.factories }
    case .empty:
      return []
    }
  }
}

@_functionBuilder
public struct FactoryBuilder {
  public static func buildBlock(_ node: FactoryNode) -> ServiceFactories {
    return node.factories
  }

  public static func buildBlock(_ nodes: FactoryNode...) -> ServiceFactories {
    return nodes.flatMap { $0.factories }
  }

  public static func buildExpression(_ producer: Prototype) -> FactoryNode {
    return .factoryNode(producer)
  }

  public static func buildExpression(_ producer: Singleton) -> FactoryNode {
    return .factoryNode(producer)
  }

  public static func buildExpression(_ producer: Session) -> FactoryNode {
    return .factoryNode(producer)
  }

  public static func buildIf(_ node: FactoryNode?) -> FactoryNode {
    if let node = node { return node }
    return .empty
  }

  public static func buildEither(first: FactoryNode) -> FactoryNode {
    return first
  }

  public static func buildEither(second: FactoryNode) -> FactoryNode {
    return second
  }
}
