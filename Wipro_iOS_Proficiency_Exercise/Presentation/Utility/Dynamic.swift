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
        didSet {
            if let value = value {
                listener?(value)
            }
        }
    }
    
    typealias Listener = (T?) -> Void
    var listener: Listener?

    init(_ value: T?) {
        self.value = value
        listener?(nil)
    }
    
    func bind(_ listener: @escaping Listener) {
        listener(self.value)
    }
}
