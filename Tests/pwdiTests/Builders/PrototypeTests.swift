//
//  PrototypeTests.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation
import XCTest
import pwdi

final class PrototypeTests: XCTestCase {
  func testBuildingAServiceOneService() {
    let prototypes = Prototype {
      Service { _ in
        ServiceA()
      }
    }

    XCTAssertEqual(prototypes.factories.count, 1)
  }

  func testBuildingAServiceTwoService() {
    let prototypes = Prototype {
      Service { _ in
        ServiceA()
      }
      Service { _ in
        ServiceB()
      }
    }

    XCTAssertEqual(prototypes.factories.count, 2)
  }

  static var allTests = [
    ("testBuildingAServiceOneService", testBuildingAServiceOneService),
    ("testBuildingAServiceTwoService", testBuildingAServiceTwoService)
  ]
}
