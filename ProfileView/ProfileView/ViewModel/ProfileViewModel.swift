//
//  ProfileViewModel.swift
//  ProfileView
//
//  Created by sambath on 18/05/23.
//

import Foundation
class ProfileViewModel {
    
    var reloadList = {() -> () in }
    init() {
        getListData()
    }

    var arrayOfList: [Results] = [] {
        didSet{
            reloadList()
        }
    }
    // MARK: - getting data for Grid
    func getListData()  {
        guard let listURL = URL(string: "https://randomuser.me/api/?page=3&results=10&seed=abc") else {
            return
        }
        
        URLSession.shared.dataTask(with: listURL){
            (data,response,error) in
            guard let jsonData = data else { return }
            do {
                let decoder = JSONDecoder()
                let jsonDatas = try decoder.decode(Model.self, from: jsonData)
                self.arrayOfList = jsonDatas.results
                print(self.arrayOfList)
            } catch let error {
                print(error)
                print("Error ->\(error.localizedDescription)")
            }
        }.resume()
    }
}

