//
//  SessionTests.swift
//  
//
//  Created by Shaun Hubbard on 4/23/20.
//

import Foundation
import XCTest
import pwdi

final class SessionTests: XCTestCase {
  func testBuildingAServiceOneService() {
    let sessions = Session {
      Service { _ in
        ServiceA()
      }
    }

    XCTAssertEqual(sessions.factories.count, 1)
  }

  func testBuildingAServiceTwoService() {
    let sessions = Session {
      Service { _ in
        ServiceA()
      }
      Service { _ in
        ServiceB()
      }
    }

    XCTAssertEqual(sessions.factories.count, 2)
  }

  static var allTests = [
    ("testBuildingAServiceOneService", testBuildingAServiceOneService),
    ("testBuildingAServiceTwoService", testBuildingAServiceTwoService)
  ]
}
