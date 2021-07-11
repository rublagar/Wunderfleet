//
//  Router.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import Alamofire

enum Router: URLRequestConvertible {
    
    case cars
    case car(carId: Int)
    case quickRental(carId: Int)
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .cars, .car:
                return .get
            case .quickRental:
                return .post
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .quickRental(let carId):
                return ["carId" : carId]
            default:
                return nil
            }
        }()
        
        let url: URL = {
            let baseURL: String = {
                return Constants.BASE_URL
            }()
            
            let relativePath: String = {
                switch self {
                case .cars:
                    return Constants.CARS_PATH
                case .car(let carId):
                    return Constants.CAR_PATH + "\(carId)"
                default:
                    return ""
                }
            }()
            
            let path: String = {
                switch self {
                case .quickRental(_):
                    return Constants.QUICK_RENTAL_URL
                default:
                    return baseURL + relativePath
                }
            }()
            
            guard let url = URL(string: path) else {
                fatalError("Invalid URL path")
            }
            return url
        }()
        
        let encoding: ParameterEncoding = {
            switch self {
            case .quickRental(_):
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        
        let headers: [String:String]? = {
            switch self {
            case .quickRental(_):
                return Constants.API_BEARER
            default:
                return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return try encoding.encode(urlRequest, with: params)
    }
    
}
