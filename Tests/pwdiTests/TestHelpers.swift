//
//  TestHelpers.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation
import pwdi

protocol MyCoolService: Injectable { }

struct ServiceA: Equatable, Injectable, MyCoolService {
    var serviceId = 1
}

struct ServiceB: Equatable, Injectable, MyCoolService {
    var serviceId = 1
}
