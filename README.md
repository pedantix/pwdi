
# pwdi - Property Wrapper Dependency Injection

  

This package is to supply a quick and easy to use dependency injection framework with many common features. This system was inspired by server side containers however it was written with the needs of clients in mind. It is not tailored for injection scopes that are common in multisession applications like servers. It is highly opinionated and probably not a fit for every project. However it was built on and for SPM as a drop in quick and easy DI container to facilitate  organization and writing testable code.

  

### Road Map

  

- [ ] Global Container

  

- [ ] Scopes - forgoing most traditional server side scopes

  

    - [ ] Prototype - Use an expiring caching strategy that responds to memory warnings

      

    - [ ] Singleton - Long lived dependencies

      

    - [ ] Session - For multi user applications

  

- [ ] Qualifiers - Traditional Tags, with a swift static `Name`

  

- [ ] Property Wrappers

  

- [ ]  Usage Guide with examples from tests

### Acknowledgement

This project is heavily inspired by Vapor. Further the Spring framework inspired the projects granular features.
