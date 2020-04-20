import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PrototypeTests.allTests),
        testCase(ServiceTests.allTests)
    ]
}
#endif
