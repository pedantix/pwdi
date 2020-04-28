//
//  ServiceIDTests.swift
//  
//
//  Created by Shaun Hubbard on 4/27/20.
//

import Foundation
import XCTest

@testable import pwdi

final class ServiceIDTests: XCTestCase {
  func testEquality_true() {
    let one = ServiceID(qualifier: .default, type: ClassBoundInjectable.self)

    let two = ServiceID(qualifier: .default, type: ClassBoundInjectable.self)

    XCTAssertEqual(one, two)
  }

  func testEquality_false() {
    let one = ServiceID(qualifier: .default, type: ClassBoundInjectable.self)

    let two = ServiceID(qualifier: .default, type: ClassBoundInjectable2.self)

    XCTAssertNotEqual(one, two)
  }

  func testHashValueEquality_true() {
    let one = ServiceID(qualifier: .default, type: ClassBoundInjectable.self)

    let two = ServiceID(qualifier: .default, type: ClassBoundInjectable.self)

    XCTAssertEqual(one.hashValue, two.hashValue)
  }

  func testHashValueEquality_false() {
    let one = ServiceID(qualifier: .default, type: ClassBoundInjectable.self)

    let two = ServiceID(qualifier: .init(name: "another"), type: ClassBoundInjectable.self)

    XCTAssertNotEqual(one.hashValue, two.hashValue)
  }
}
