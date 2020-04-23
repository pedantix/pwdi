//
//  SingletonTests.swift
//  
//
//  Created by Shaun Hubbard on 4/23/20.
//

import Foundation
import XCTest
import pwdi

final class SingletonTests: XCTestCase {
  func testBuildingAServiceOneService() {
    let singletons = Singleton {
      Service { _ in
        ServiceA()
      }
    }

    XCTAssertEqual(singletons.factories.count, 1)
  }

  func testBuildingAServiceTwoService() {
    let singletons = Singleton {
      Service { _ in
        ServiceA()
      }
      Service { _ in
        ServiceB()
      }
    }

    XCTAssertEqual(singletons.factories.count, 2)
  }

  static var allTests = [
    ("testBuildingAServiceOneService", testBuildingAServiceOneService),
    ("testBuildingAServiceTwoService", testBuildingAServiceTwoService)
  ]
}
