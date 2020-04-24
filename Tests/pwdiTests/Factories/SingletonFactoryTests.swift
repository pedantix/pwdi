//
//  SingletonFactoryTests.swift
//
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation
import XCTest
@testable import pwdi

private let testService = Service { _ in
  ClassBoundInjectable()
}

final class SingletonFactoryTests: XCTestCase {
  func testGet_createsInjectible() throws {
    let factory = SingletonFactory(service: testService)
    let injectable = try factory.get(container: DummyContainer())
    XCTAssertTrue(injectable is ClassBoundInjectable)
  }

  func testGet_createsAUniqueInjectibleOnce() throws {
    let factory = SingletonFactory(service: testService)
    let container = DummyContainer()
    let injectable = try factory.get(container: container) as AnyObject
    let injectable2 = try factory.get(container: container) as AnyObject
    XCTAssertTrue(injectable === injectable2)
  }

  static var allTests = [
    ("testGet_createsInjectible", testGet_createsInjectible),
    ("testGet_createsAUniqueInjectibleOnce", testGet_createsAUniqueInjectibleOnce)
  ]
}
