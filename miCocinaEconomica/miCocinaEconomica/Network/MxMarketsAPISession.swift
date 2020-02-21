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
    
    func getAllIngredientsList() {
        
        let mxMarketsURL = URL(string: "https://mxmarkets.herokuapp.com/api/v1/products/")!
        let request = URLRequest(url: mxMarketsURL)
            let task = session.dataTask(with: request) {
                (data, response, error) -> Void in
                if let jsonData = data {
                    if let jsonString = String(data: jsonData, encoding: .utf8) {

                        print(jsonString)
                    }
                        } else if let requestError = error {
                    print("Error fetching interesting photos: \(requestError)")
                    } else {
                    print("Unexpected error with the request")
                    }
                }
            task.resume()
        }
    
}

