//
//  ContactsViewModel.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import Foundation



class ContactsViewModel {
    
    private let networkService = NetworkService.shared
    
    var contacts: [Contact]?
    weak var mainCoordinator: MainCoordinator?
    
    func fetchContacts(completion: @escaping () -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        networkService.decodeData(urlRequest: URLRequest(url: url), ofType: [Contact].self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.contacts = model
                    completion()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func showContacts(userId: Int) {
        mainCoordinator?.showDetailViewWith(userId: userId)
    }
}
