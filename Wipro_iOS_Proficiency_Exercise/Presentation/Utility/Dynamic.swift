//
//  Dynamic.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import Foundation

class Dynamic<T> {

    public var value: T? {
        willSet {
            listener?(newValue)
        }
    }

    typealias Listener = (T?) -> Void
    var listener: Listener?

    init(_ value: T?) {
        self.value = value
    }

    func bind(_ listenerValue: @escaping Listener) {
        self.listener = listenerValue
    }
}
