//
//  CoinViewCell.swift
//  CoinTracking
//
//  Created by Marco Mascorro on 10/15/22.
//

import UIKit



class CoinViewCell: UITableViewCell {
    
    
    
    
    //MARK: - Properties
    var coin: coinModel? {
        didSet{
            configureCoinCell()
        }
    }
    
    
    
    
    private let coinTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        
        return label
    }()
    
    private let coinPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        
        return label
    }()
    
    private let coinSymbol: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    
    //MARK: - Helpers

    private func configureUI(){
        
        addSubview(coinSymbol)
        addSubview(coinTitle)
        addSubview(coinPrice)
        
        
        coinSymbol.anchor(top: topAnchor, left: leftAnchor , paddingTop: 12, paddingLeft: 12)
        coinTitle.anchor(top: topAnchor, left: coinSymbol.rightAnchor , paddingTop: 12, paddingLeft: 12)
        coinPrice.anchor(top: topAnchor, left: coinTitle.rightAnchor , paddingTop: 12, paddingLeft: 12)
        
        
        
        
        
        
        
    }
    
    private func configureCoinCell(){
        
        guard let coin = coin else { return }
        coinTitle.text = coin.name
        coinPrice.text = coin.price
        coinSymbol.text = coin.symbol
        

        
        
    }
    
    
    
    
}
