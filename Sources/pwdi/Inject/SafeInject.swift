//
//  SafeInject.swift
//  
//
//  Created by Shaun Hubbard on 4/28/20.
//

import Foundation

@propertyWrapper
public class SafeInject<T> {
  private let qualifier: Qualifier

  private var cachedValue: T?

  public init(qualifier: Qualifier = .default) {
    self.qualifier = qualifier
  }

  public var wrappedValue: T? {
    guard cachedValue == nil else { return cachedValue }
    do {
      let value = try globalContainer.make(T.self, qualifier: qualifier)
      cachedValue = value
      return value
    } catch {
      return nil
    }
  }
}
