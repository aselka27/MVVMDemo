//
//  CommentsViewModel.swift
//  MVVMDemo
//
//  Created by саргашкаева on 20.03.2023.
//

import Foundation

class CommentsViewModel {
    
    var comments: [Comment]?
    private let networkService = NetworkService.shared
    var userId: Int = 0
    
     func fetchComments(completion: @escaping ()->()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else { return }
        networkService.decodeData(urlRequest: URLRequest(url: url), ofType: [Comment].self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.comments = model
                    completion()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
