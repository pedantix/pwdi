//
//  InjectTests.swift
//
//
//  Created by Shaun Hubbard on 4/30/20.
//

import Foundation
import XCTest
import pwdi
#if canImport(Darwin)
import Nimble
#endif

private class DummyClass {
  @Inject var serviceA: ServiceA
}

final class InjectTests: GlobalContainerTestCase {
  func testInjectingWhenObjectDoesNotExist() {
    #if canImport(Darwin)
    expect { () -> Void in
      _ = DummyClass().serviceA
    }.to(throwAssertion())
    #endif
  }

  func testInjectingWhenObjectDoesExist() {
    GlobalContainer {
      Prototype {
        Service { _ in ServiceA() }
      }
    }

    XCTAssertNotNil(DummyClass().serviceA)
  }

  static var allTests = [
    ("testInjectingWhenObjectDoesExist", testInjectingWhenObjectDoesExist)
  ]
}
