import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PrototypeTests.allTests),
        testCase(ServiceTests.allTests),
        testCase(SingletonTests.allTests),
        testCase(SessionTests.allTests),
        testCase(ConcurrencyTests.allTests),
        testCase(PrototypeFactoryTests.allTests),
        testCase(ServiceFactoriesContainerTests.allTests),
        testCase(ServiceCacheTests.allTests),
        testCase(GlobalContainerTests.allTests),
        testCase(InjectTests.allTests),
        testCase(SafeInjectTests.allTests)
  ]
}
#endif
