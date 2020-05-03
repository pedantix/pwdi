
# pwdi - Property Wrapper Dependency Injection

![Swift](https://github.com/pedantix/pwdi/workflows/Swift/badge.svg)
![SwiftLint](https://github.com/pedantix/pwdi/workflows/SwiftLint/badge.svg)
  

This package is to supply a quick and easy to use dependency injection framework with many common features. This system was inspired by server side containers however it was written with the needs of clients in mind. It is not tailored for injection scopes that are common in multisession applications like servers. It is highly opinionated and probably not a fit for every project. However it was built on and for SPM as a drop in quick and easy DI container to facilitate  organization and writing testable code.


### Usage
All usage can be derived from unit tests.

#### Using `@SafeInject`:

```Swift

func setupTheContainerSomeWhere() {
  GlobalContainer {
    Prototype {
      Service { _ in Bar() }
    }
  }
}

class Foo {
  @SafeInject vara bar: Bar?
  @SafeInject vara baz: Baz?
}

func someCodeSomeWhereInYourProject() {
  let foo = Foo()
  foo.bar // instance of bar optionally wrapped
  foo.baz // nil
}
```

#### Using `@Inject`:

```Swift

func setupTheContainerSomeWhere() {
  GlobalContainer {
    Prototype {
      Service { _ in Bar() }
    }
  }
}

class Foo {
  @Inject vara bar: Bar
  @Inject vara baz: Baz
}

func someCodeSomeWhereInYourProject() {
  let foo = Foo()
  foo.bar // instance of bar
  foo.baz // Never -> fatalError()
}
```

#### Using `Qualifier`:
When your container has more then one instance of a type(class, protocol, struct) registered you must use a Qualifier to disambiguate it or in the case of `@SafeInject` nil. will be returend and in the case of `@Inject` a fatalError will be triggered.

```Swift
extension Qualifier {
  static let myQualifier = Qualifier(name: "my_qual")
}

func setupTheContainerSomeWhere() {
  GlobalContainer {
    Prototype {
      Service { _ in Bar() }
    }
    Singleton {
      Service { _ in Bar() }.qualifier(.myQualifier)
    }
  }
}

class Foo {
  @Inject vara bar: Bar
  @Inject(.myQualifier) vara myBar: Bar
}

func someCodeSomeWhereInYourProject() {
  let foo = Foo()
  foo.bar // instance of bar
  foo.bar // instance of bar
}
```

#### Scopes


```Swift

func setupTheContainerSomeWhere() {
  GlobalContainer {
    Prototype {
      Service { _ in Foo() }
    }
    Singleton {
      Service { _ in Bar() }
    }
    Session {
      Service { _ in Baz() }
    }
  }
}

class MyInjectedObject {
  @Inject var foo: Foo
  @Inject var bar: Bar
  @Inject var baz: Baz
  @Inject var container: Container
}

func prototypeExample() {
  let obj1 = MyInjectedObject()
  let obj2 = MyInjectedObject()
  obj1.foo // 0x001, a different object every injection
  obj2.foo // 0x002, a different object every injection
}

func singletonExample() {
  let obj1 = MyInjectedObject()  
  let obj2 = MyInjectedObject()  
  obj1.bar // instance 0x001.
  ob2bar // instance 0x001. the same instance until the app resets
}

func sessionExample() {
  let obj1 = MyInjectedObject()  
  let obj2 = MyInjectedObject()  
  let obj3 = MyInjectedObject()  
  
  obj1.baz // instance 0x001.
  obj2.baz // instance 0x001. the same instance until the session is reset
  container.resetSession()
  obj3.baz // instance 0x002
}
```

### Road Map

  

- [X] Global Container

  

- [X] Scopes - forgoing most traditional server side scopes

  

    - [X] Prototype - Use an expiring caching strategy that responds to memory warnings

      

    - [X] Singleton - Long lived dependencies

      

    - [X] Session - For multi user applications

  

- [X] Qualifiers - Traditional Tags, with a swift static `Name`

  

- [X] Property Wrappers - for injection `@Inject` and `@Inject(Qualifier.notDefault)`
  

- [X]  Usage Guide with examples from tests

### Acknowledgement

This project is heavily inspired by Vapor. Further the Spring framework inspired the projects granular features.

### Motivation

Testing Cocoa frameworks can be hard, its almost as if they are setup without testing in mind. There are many strategies to get around this however using a DI(dependency injection) strategy provides a common way of helping with this effort. This project was written to enable TDD accross active projects as they upgrade to swift 5, with a common set of tools. After the initial milestoes are met please add issues to expand functionality.
