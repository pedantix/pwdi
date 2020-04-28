//
//  Container.swift
//  
//
//  Created by Shaun Hubbard on 4/7/20.
//

public protocol Container: class {
    /// Make a service based on an interface.
    func make<S>(_ type: S.Type) throws -> S

  /// Make a service based on an interface restricted by qualifier.
  func make<S>(_ type: S.Type, qualifier: Qualifier) throws -> S
}
