import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(pwdiTests.allTests),
        testCase(PrototypeTests.allTests),
        testCase(serviceBuilderTests.allTests)
    ]
}
#endif
