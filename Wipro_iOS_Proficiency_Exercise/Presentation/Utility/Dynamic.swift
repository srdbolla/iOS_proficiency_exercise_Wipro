//
//  Dynamic.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import Foundation

/**
 Dynamic is used to listen to the new values and bind them when there is change in the data values
 */
class Dynamic<T> {

    /**
     If there is any change in the value, value is updated and listener is called
    */
    public var value: T? {
        willSet {
            listener?(newValue)
        }
    }

    /**
     To listen to the data
    */
    typealias Listener = (T?) -> Void
    var listener: Listener?

    /**
     Initializer
    */
    init(_ value: T?) {
        self.value = value
    }
    
    
    /**
     Binding th data to the listener
    */
    func bind(_ listenerValue: @escaping Listener) {
        self.listener = listenerValue
    }
}
