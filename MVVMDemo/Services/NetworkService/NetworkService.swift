//
//  NetworkService.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import Foundation
import Alamofire



enum NetworkingError: Error {
    case notFound
    case serverTroubleShooting
    case notRegistered
    case unautuhorized
    case badData
}

enum NetworkErrors: Error {
    case failedToDecode(errorDescription: String)
    case otherError(error: String)
}
class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    private func getRequest ( urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error occured")
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
    
    func decodeData<T: Codable> (urlRequest: URLRequest, ofType: T.Type, response: @escaping (Result<T, NetworkErrors>) -> Void) {
        getRequest(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    response(.success(decodedData))
                    print(decodedData)
                } catch let jsonError{
                    response(.failure(.failedToDecode(errorDescription: jsonError.localizedDescription)))
                }
            case .failure(let error):
                response(.failure(.otherError(error: error.localizedDescription)))
                print("Error has occured\(error.localizedDescription)")
            }
        }
    }
    
    private func validateError(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        if let error = error {
            return error
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return URLError(.badServerResponse)
        }
        switch httpResponse.statusCode {
        case 200...210:
            return nil
        case 401:
            return NetworkingError.unautuhorized
        default:
           return nil
        }
    }
    
    func transformJSON <T: Decodable>(data: Data?, objectType: T.Type) -> T? {
        guard let data = data else {return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
