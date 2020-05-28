//
//  RestAPI.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
	case GET = "GET"
	case PUT = "PUT"
	case POST = "POST"
	case DELETE = "DELETE"
}

enum API: String {
	case community = "http://ec2-3-85-177-214.compute-1.amazonaws.com/api"
	
	func baseURL() -> String {
		return self.rawValue
	}
}

typealias Parameters = [String: Any]
typealias Headers = [String: String]

class RestAPI {
	
	private static var session = URLSession.shared

	class func request<T: Decodable>(_ toAPI: API,
									 path: String,
									 method: HTTPMethod,
									 params: Parameters? = nil,
									 body: Encodable? = nil,
									 headers: Headers? = nil,
									 done: @escaping Response<T>) {
		
		func getToken() -> String? {
			if let token = User.shared.token {
				return "Bearer " + token
			} else {
				return nil
			}
		}
		
		guard let url = URL(string: toAPI.baseURL() + path) else {
			done(.failure(.NoURL))
			return
		}
		
		var request: URLRequest!
		
		if let params = params {
			var componets = URLComponents(url: url, resolvingAgainstBaseURL: false)
			componets?.queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value as? String) })
			request = URLRequest(url: componets?.url ?? url)
		} else {
			request = URLRequest(url: url)
		}
		
		request.httpMethod = method.rawValue
		
		if toAPI == .community {
			if let token = getToken() {
				let authString:NSString = NSString(format: "%@", token)
				request.setValue(authString as String, forHTTPHeaderField: "Authorization")
			}
		}
		
		if let body = body {
			
			let jsonEncoder = JSONEncoder()
			
			do {
				let encodableBox = AnyEncodable(value: body)
				request.httpBody = try jsonEncoder.encode(encodableBox)
			} catch (let error) {
				done(.failure(.BodyEncoding(error)))
			}
			
		}
		
		request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		if let headers = headers {
			for (headerKey, headerValue) in headers { request.addValue(headerKey, forHTTPHeaderField: headerValue) }
		}
		
		let session = self.session
		session.configuration.timeoutIntervalForRequest = 30.0
		session.configuration.timeoutIntervalForResource = 30.0
				   
		let requestTask = session.dataTask(with: request) { (optData, response, error) -> Void in
			
			if let requestError = error {
				done(.failure(.Error(requestError)))
			} else {
				
				guard
					let data = optData,
					let response = response as? HTTPURLResponse else {
						done(.failure(.Error(nil)))
						return
				}
				
				guard (200 ..< 300) ~= response.statusCode else {
					done(.failure(.StatusCode(response.statusCode)))
					return
				}
				
				let jsonDecoder = JSONDecoder()
				jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
				
				do {
					let mappedResponse = try jsonDecoder.decode(T.self, from: data)
					done(.success(mappedResponse))
				} catch let DecodingError.dataCorrupted(context) {
					done(.failure(.Error(context.underlyingError)))
					
				} catch let DecodingError.keyNotFound(key, context) {
					print("key: \(key), error: \(String(describing: context.underlyingError))")
					done(.failure(.Error(context.underlyingError)))
					
				} catch let DecodingError.valueNotFound(key, context) {
					print("key: \(key), error: \(String(describing: context.underlyingError))")
					done(.failure(.Error(context.underlyingError)))
					
				} catch let DecodingError.typeMismatch(key, context)  {
					print("key: \(key), error: \(String(describing: context.underlyingError))")
					done(.failure(.Error(context.underlyingError)))
					
				} catch (let error) {
					done(.failure(.Error(error)))
					
				}
			}
		}
		requestTask.resume()
	}
}
