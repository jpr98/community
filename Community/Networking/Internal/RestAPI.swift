//
//  RestAPI.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

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
	
	class func uploadImage(_ toAPI: API,
						   path: String,
						   paramName: String,
						   fileName: String,
						   image: UIImage,
						   completion: @escaping (Bool)->()) {
		
		func getToken() -> String? {
			if let token = User.shared.token {
				return "Bearer " + token
			} else {
				return nil
			}
		}
		
		guard let url = URL(string: toAPI.baseURL() + path) else {
			completion(false)
			return
		}

		// generate boundary string using a unique per-app string
		let boundary = UUID().uuidString

		let session = URLSession.shared

		// Set the URLRequest to POST and to the specified URL
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = HTTPMethod.PUT.rawValue

		// Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
		// And the boundary is also set here
		urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

		if toAPI == .community {
			if let token = getToken() {
				let authString:NSString = NSString(format: "%@", token)
				urlRequest.setValue(authString as String, forHTTPHeaderField: "Authorization")
			}
		}
		
		var data = Data()

		// Add the image data to the raw http request data
		data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
		data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
		data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
		
		let imgData = image.jpegData(compressionQuality: 0.2)!
		data.append(imgData)

		data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

		// Send a POST request to the URL, with the data we created earlier
		session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
			if error == nil {
				let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
				if let json = jsonData as? [String: Any] {
					print(json)
					completion(true)
				} else {
					completion(false)
				}
			} else {
				completion(false)
			}
		}).resume()
	}
	
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
