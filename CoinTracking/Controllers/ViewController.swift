//
//  ViewController.swift
//  CoinTracking
//
//  Created by Marco Mascorro on 10/15/22.
//

import UIKit


private let reuseID = "reuseId"


class ViewController: UITableViewController {

    //MARK: - Properties
    private var coins = [coinModel](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    lazy var refreshControlller: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshTweets), for: .valueChanged)
        
        return rc
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CoinViewCell.self, forCellReuseIdentifier: reuseID)
        fetchCoinData()
        configureUI()
        tableView.refreshControl = refreshControlller
    }
    
    //MARK: - Selectors
    @objc private func refreshTweets(){
        fetchCoinData()
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.refreshControlller.endRefreshing()
            
        }
    }
    //MARK: - Helpers
    
    func fetchCoinData(){
        CoinManager.shared.getCoinData { coin in
            self.coins = coin
        }
    }
    
    func configureUI(){
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }


}


extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(coins.count)
        return coins.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! CoinViewCell
        cell.coin = coins[indexPath.row]
        return cell
    }
    
    
    
    
}
