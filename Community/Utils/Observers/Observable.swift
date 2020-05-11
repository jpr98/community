//
//  Observable.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

public class Observable<T> {
	public typealias Observer = (_ observable: Observable<T>, T) -> Void
	
	private var observers: [Observer]
	
	public var value: T? {
		didSet {
			if let value = value {
				notifyObservers(value)
			}
		}
	}
	
	public init(_ value: T? = nil) {
		self.value = value
		observers = []
	}
	
	public func addObserver(_ observer: @escaping Observer) {
		if let value = value {
			observer(self, value)
		}
		self.observers.append(observer)
	}
	
	private func notifyObservers(_ value: T) {
		self.observers.forEach { [unowned self](observer) in
			observer(self, value)
		}
	}
	
	deinit {
		observers.removeAll()
	}
}

protocol Observer {
	associatedtype T: Equatable
	func bind(_ o: Observable<T>)
}
