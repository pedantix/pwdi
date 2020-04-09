//
//  TestHelpers.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation
import pwdi

protocol MyCoolService { }

struct ServiceA: Equatable, Service, MyCoolService {
    var serviceId = 1
}

struct ServiceB: Equatable, Service, MyCoolService {
    var serviceId = 1
}
