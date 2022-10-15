//
//  CoinManager.swift
//  CoinTracking
//
//  Created by Marco Mascorro on 10/15/22.
//

import Foundation


class CoinManager {
    
    static let shared = CoinManager()
    
    
    
    func getCoinData(completion: @escaping([coinModel])-> Void){
        
        let headers = [
            "X-RapidAPI-Key": "d7f379502cmsh5d9b36284c12d1ep1bbaffjsn643e4aa52a0c",
            "X-RapidAPI-Host": "coinranking1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://coinranking1.p.rapidapi.com/coins?referenceCurrencyUuid=yhjMzLPhuIDl&timePeriod=24h&tiers%5B0%5D=1&orderBy=marketCap&orderDirection=desc&limit=50&offset=0")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print(httpResponse)
            
            if let data = data {
                guard let collecteddata = self.parseJSON(data) else { return }
//                print(self.parseJSON(data))
                completion(collecteddata)
                
            }
            
        })
        
        dataTask.resume()
    }
    
    func parseJSON(_ coinData: Data)-> [coinModel]? {
        
        let decoder = JSONDecoder()
        var models = [coinModel]()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            
            
            
            for i in 0...decodedData.data.coins.count - 1 {
                let coin = decodedData.data.coins[i]
                let coinModel = coinModel(uuid: coin.uuid, symbol: coin.symbol, name: coin.name, price: coin.price)
                models.append(coinModel)
            }
            return models
        } catch {
            return nil
        }
    }
    
    
    
}

