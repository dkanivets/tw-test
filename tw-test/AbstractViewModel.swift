//
//  AbstractViewModel.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 10.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import ReactiveSwift

//TODO
protocol AbstractViewModelProtocol {
    associatedtype T
    var updateItemsAction: Action<Void, [T], NSError> { get }
    var items: [T] { get }
}
