//
//  NetworkTypes.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case NoURL
	case BodyEncoding(_ error: Error?)
	case Error(_ error: Error?)
	case StatusCode(_ code: Int)
}

typealias Response<Type: Decodable> = (Result<Type, NetworkError>) -> Void

