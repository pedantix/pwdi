//
//  SessionFactoryTests.swift
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

final class SessionFactoryTests: XCTestCase {
  func testGet_createsInjectible() throws {
    let factory = SessionFactory(service: testService)
    let injectable = try factory.get(container: DummyContainer())
    XCTAssertTrue(injectable is ClassBoundInjectable)
  }

  func testGet_createsAUniqueInjectible_whileInTheSameSession() throws {
    let factory = SessionFactory(service: testService)
    let container = DummyContainer()
    let injectable = try factory.get(container: container) as AnyObject
    let injectable2 = try factory.get(container: container) as AnyObject
    XCTAssertTrue(injectable === injectable2)
  }

  func testGet_createsADifferentInjectible_whenTheSessionChanges() throws {
    let factory = SessionFactory(service: testService)
    let container = DummyContainer()
    let injectable = try factory.get(container: container) as AnyObject
    factory.sessionChanged()
    let injectable2 = try factory.get(container: container) as AnyObject
    XCTAssertFalse(injectable === injectable2)
  }

  static var allTests = [
    ("testGet_createsInjectible", testGet_createsInjectible),
    ("testGet_createsAUniqueInjectible_whileInTheSameSession",
     testGet_createsAUniqueInjectible_whileInTheSameSession),
    ("testGet_createsADifferentInjectible_whenTheSessionChanges",
     testGet_createsADifferentInjectible_whenTheSessionChanges)
  ]
}
