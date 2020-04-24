//
//  Concurrency.swift
//  
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation
import XCTest

@testable import pwdi

final class ConcurrencyTests: XCTestCase {

  func testReturnsValue() throws {
    let thing = "Thing"
    try XCTAssertEqual(threadSafeExecute { thing }, thing)
  }

  func testIsCalledOnADifferntQueue() throws {
    let blockExpectation = expectation(description: "this should be called twice")

    let marker = DispatchSpecificKey<UUID>()
    let uuid = UUID()
    DispatchQueue.main.setSpecific(key: marker, value: uuid)

    blockExpectation.expectedFulfillmentCount = 2

    let isOnCurrentQueueBlock = { () -> Bool in
      blockExpectation.fulfill()
      return DispatchQueue.getSpecific(key: marker) == uuid
    }

    XCTAssertTrue(isOnCurrentQueueBlock())

    try XCTAssertFalse(threadSafeExecute(isOnCurrentQueueBlock))
    waitForExpectations(timeout: 3, handler: .none)
  }

  func testIsSafeToCallWithinItself() throws {
    let blockExpectation = expectation(description: "This should be called")

    _ = try threadSafeExecute { () -> String in
      return try threadSafeExecute {
        blockExpectation.fulfill()
        return "Dogs"
      }
    }

    waitForExpectations(timeout: 3, handler: .none)
  }

  static var allTests = [
    ("testReturnsValue", testReturnsValue)
  ]
}
