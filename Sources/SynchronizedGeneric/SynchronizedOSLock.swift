//
//  File 2.swift
//  
//
//  Created by Basem Emara on 2019-10-05.
//

import Foundation

public class SynchronizedOSLock<Value> {
    private var mutex = os_unfair_lock_s()
    private var _value: Value
 
    public init(_ value: Value) {
        self._value = value
    }
    
    /// Returns or modify the value.
    public var value: Value { lock { _value } }
    
    /// Submits a block for synchronous execution with this lock.
    public func value<T>(execute task: (inout Value) throws -> T) rethrows -> T {
        try lock { try task(&_value) }
    }
}
 
private extension SynchronizedOSLock {
    
    /// Attempts to acquire a lock, blocking a thread’s execution until the
    /// process can be executed, then relinquishes a previously acquired lock.
    func lock<T>(execute task: () throws -> T) rethrows -> T {
        os_unfair_lock_lock(&mutex)
        defer { os_unfair_lock_unlock(&mutex) }
        return try task()
    }
}
