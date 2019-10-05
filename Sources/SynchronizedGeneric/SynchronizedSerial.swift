//
//  SynchronizedSerial.swift
//  
//
//  Created by Basem Emara on 2019-10-05.
//

import Foundation

public struct SynchronizedSerial<Value> {
    private let mutex = DispatchQueue(label: "io.zamzam.SynchronizedSerial")
    private var _value: Value
 
    public init(_ value: Value) {
        self._value = value
    }
 
    public var value: Value { mutex.sync { _value } }
 
    public mutating func value<T>(execute task: (inout Value) throws -> T) rethrows -> T {
        try mutex.sync { try task(&_value) }
    }
}
