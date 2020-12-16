//
//  FluentInterface.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation

@dynamicMemberLookup
struct FluentInterface<Subject> {
    let subject: Subject
    
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Subject, Value>) -> ((Value) -> FluentInterface<Subject>) {
        var subject = self.subject
        
        return { value in
            subject[keyPath: keyPath] = value
            return FluentInterface(subject: subject)
        }
    }
}

postfix operator +
postfix func + <T>(lhs: T) -> FluentInterface<T> {
    FluentInterface(subject: lhs)
}

postfix operator -
postfix func - <T>(lhs: FluentInterface<T>) -> T {
    lhs.subject
}
