//
//  SearchApi.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/02.
//

import Foundation

class SearchApi {
    static let path: String = "https://api.github.com/search/repositories"
    static func search(_ keyword: String,
                       _ per_page: Int = 25,
                       _ completion: @escaping (([Repository]) -> Void)) {
        
        guard let url = URL(string: SearchApi.path + "?q=\(keyword)") else {
            print("url initialize failed")
            return
        }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: 3)
        
        
        request.httpMethod = "GET"
        print(request)
        DispatchQueue.global(qos: .background).async {
            session.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    if let err = error {
                        print(err)
                        return
                    }
                    
                    guard let response = response,
                          let data = data,
                          let json = String(data: data, encoding: .utf8)
                    else {
                        print("something went wrong")
                        return
                    }
                    
                    
                    do {
                        let result = try JSONDecoder().decode(RepositoryResult.self, from: data)
                        completion( result.items.map({ $0.toRepository() }))
                    } catch let error {
                        print(error)
                    }
                }
                
            }.resume()
        }
        
            
    }
}
