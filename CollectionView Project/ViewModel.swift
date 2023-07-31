//
//  ViewModel.swift
//  Sample2
//
//  Created by Ajay Sarkate on 26/07/23.
//

import UIKit

class ViewModel {
    
    let urlString = "https://api.unsplash.com/photos/random?client_id=X68Hk72JPLJ6JzNAbU_sM5S0RzMnBN8BWSLXRCVCJts"
    
    func loadData(onCompletion: @escaping ([Tag]) -> ()) {
        guard let url = URL(string: urlString)  else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print(123, err)
                return
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    onCompletion(result.tags)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
