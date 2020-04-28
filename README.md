
# pwdi - Property Wrapper Dependency Injection

![Swift](https://github.com/pedantix/pwdi/workflows/Swift/badge.svg)
![SwiftLint](https://github.com/pedantix/pwdi/workflows/SwiftLint/badge.svg)
  

This package is to supply a quick and easy to use dependency injection framework with many common features. This system was inspired by server side containers however it was written with the needs of clients in mind. It is not tailored for injection scopes that are common in multisession applications like servers. It is highly opinionated and probably not a fit for every project. However it was built on and for SPM as a drop in quick and easy DI container to facilitate  organization and writing testable code.

  

### Road Map

  

- [X] Global Container

  

- [X] Scopes - forgoing most traditional server side scopes

  

    - [X] Prototype - Use an expiring caching strategy that responds to memory warnings

      

    - [X] Singleton - Long lived dependencies

      

    - [X] Session - For multi user applications

  

- [X] Qualifiers - Traditional Tags, with a swift static `Name`

  

- [ ] Property Wrappers - for injection `@Inject` and `@Inject(Qualifier.notDefault)`
  

- [ ]  Usage Guide with examples from tests

### Acknowledgement

This project is heavily inspired by Vapor. Further the Spring framework inspired the projects granular features.

### Motivation

Testing Cocoa frameworks can be hard, its almost as if they are setup without testing in mind. There are many strategies to get around this however using a DI(dependency injection) strategy provides a common way of helping with this effort. This project was written to enable TDD accross active projects as they upgrade to swift 5, with a common set of tools. After the initial milestoes are met please add issues to expand functionality.
