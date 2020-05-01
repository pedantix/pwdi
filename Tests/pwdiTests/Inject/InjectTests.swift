//
//  InjectTests.swift
//
//
//  Created by Shaun Hubbard on 4/30/20.
//

import Foundation
import XCTest
import pwdi
import Nimble

private class DummyClass {
  @Inject var serviceA: ServiceA
}

final class InjectTests: GlobalContainerTestCase {
  func testInjectingWhenObjectDoesNotExist() {
    expect { () -> Void in
      _ = DummyClass().serviceA
    }.to(throwAssertion())
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
    ("testInjectingWhenObjectDoesNotExist", testInjectingWhenObjectDoesNotExist),
    ("testInjectingWhenObjectDoesExist", testInjectingWhenObjectDoesExist)
  ]
}
