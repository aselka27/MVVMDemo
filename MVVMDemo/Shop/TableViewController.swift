//
//  TableViewController.swift
//  MVVMDemo
//
//  Created by саргашкаева on 17.03.2023.
//

import UIKit
import Combine

class TableViewController: UITableViewController {
    
    
    private let products: [Product] = Product.collection
    
    @Published private var cart: [Product: Int] = [:]
    @Published private var likes: [Product: Bool] = [:]
    
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        observe()
    }
    
    private func observe() {
      $cart.dropFirst().sink { [unowned self] dict in
        dict.forEach { k,v in
          print("\(k.name) - \(v)")
        }
        print("=======")
        tableView.reloadData()
      }.store(in: &cancellables)
      
      $likes.dropFirst().sink { [unowned self] dict in
        let products = dict.filter({ $0.value == true }).map({ $0.key.name })
        print("❤️ \(products)")
        tableView.reloadData()
      }.store(in: &cancellables)
    }
          
    private func handleCellEvent(product: Product, indexPath: IndexPath, event: ProductCellEvent) {
      switch event {
      case .quantityDidChange(let value):
        cart[product] = value
      case .heartDidTap:
        if let value = likes[product] {
          likes[product] = !value
        } else {
          likes[product] = true
        }
      }
    }
    
    private var numberOfItemsInCart: Int {
      return cart.reduce(0, { x, y in
        x + y.value
      })
    }
    
    private var totalCost: Int {
      return cart.reduce(0, { x, y in
        x + (y.value * y.key.price)
      })
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
      cart.removeAll()
      likes.removeAll()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! ProductTableViewCell
          let product = products[indexPath.item]
          cell.setProduct(product: product, quantity: cart[product] ?? 0, isLiked: likes[product] ?? false)
          cell.eventPublisher.sink { [weak self] event in
            self?.handleCellEvent(product: product, indexPath: indexPath, event: event)
          }.store(in: &cell.cancellables)
          return cell
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 88
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return String(format: "Number of items: %d", numberOfItemsInCart)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
      return String(format: "Total cost: $%d", totalCost)
    }

}
