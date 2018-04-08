//
//  SwiftExtensions.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 08.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import Foundation

extension Array {

    func failableMap<U>(_ transform: (Element) -> U?) -> [U]? {
        return self.map(transform).reduce([U]()) { p, n -> [U]? in
            if let previous = p, let next = n {
                return previous + [next]
            } else {
                return nil
            }
        }
    }
}
