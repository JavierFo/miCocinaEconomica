//
//  MxMarketsAPISession.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/21/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class MxMarketsAPISession{
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func getAllIngredientsList(completion: @escaping ([IngredientsList]) -> Void) {
        
        let mxMarketsURL = URL(string: "https://mxmarkets.herokuapp.com/api/v1/products/")!
        let request = URLRequest(url: mxMarketsURL)
            let task = session.dataTask(with: request) {
                (data, response, error) -> Void in
                
                let jsonDecoder = JSONDecoder()
                if let data = data, let productList = try? jsonDecoder.decode([IngredientsList].self, from: data){
                    completion(productList)
                }   else if let requestError = error {
                    print("Error fetching interesting photos: \(requestError)")
                    } else {
                    print("Unexpected error with the request")
                    }
                }
        
            task.resume()
        }
    
    func getDetailedIngredientInfo(withID id : Int, completion: @escaping (IngredientDetails) -> Void) {
        
        let mxMarketsURL = URL(string: "https://mxmarkets.herokuapp.com/api/v1/products/\(id)")!
        let request = URLRequest(url: mxMarketsURL)
            let task = session.dataTask(with: request) {
                (data, response, error) -> Void in
                
                let jsonDecoder = JSONDecoder()
                if let data = data, let productDetails = try? jsonDecoder.decode(IngredientDetails.self, from: data){
                    completion(productDetails)
                }   else if let requestError = error {
                    print("Error fetching interesting photos: \(requestError)")
                    } else {
                    print("Unexpected error with the request")
                    }
                }
            task.resume()
        }
    
}

