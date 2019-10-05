//
//  File 3.swift
//  
//
//  Created by Basem Emara on 2019-10-05.
//

import Foundation

public struct SynchronizedNSLock<Value> {
    private var mutex = NSLock()
    private var _value: Value
 
    public init(_ value: Value) {
        self._value = value
    }
    
    /// Returns or modify the value.
    public var value: Value { mutex.lock { _value } }
    
    /// Submits a block for synchronous execution with this lock.
    public mutating func value<T>(execute task: (inout Value) throws -> T) rethrows -> T {
        try mutex.lock { try task(&_value) }
    }
}
 
private extension NSLocking {
    
    /// Attempts to acquire a lock, blocking a thread’s execution until the
    /// process can be executed, then relinquishes a previously acquired lock.
    func lock<T>(execute task: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try task()
    }
}
