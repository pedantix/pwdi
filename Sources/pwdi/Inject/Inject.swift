//
//  Inject.swift
//  
//
//  Created by Shaun Hubbard on 4/28/20.
//

import Foundation

@propertyWrapper
public class Inject<T> {
  private let qualifier: Qualifier
  private var value: T?
  public init(qualifier: Qualifier = .default) {
    self.qualifier = qualifier
  }

  public var wrappedValue: T {
    if let val = value { return val }
    do {
      let val = try globalContainer.make(T.self, qualifier: qualifier)
      value = val
      return val
    } catch {
      preconditionFailure(error.localizedDescription)
    }
  }
}
