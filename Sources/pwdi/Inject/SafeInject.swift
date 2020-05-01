//
//  SafeInject.swift
//  
//
//  Created by Shaun Hubbard on 4/28/20.
//

import Foundation

@propertyWrapper
public struct SafeInject<T> {
  private let qualifier: Qualifier

  public init(qualifier: Qualifier = .default) {
    self.qualifier = qualifier
  }

  public var wrappedValue: T? {
    do {
      return try globalContainer.make(T.self, qualifier: qualifier)
    } catch {
      return nil
    }
  }
}
