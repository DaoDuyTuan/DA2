//
//  CoinDetailTableViewController.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/25/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import UIKit

class CoinDetailTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var marketCapTitleLabel: UILabel!
    @IBOutlet weak var volume24hrTitleLabel: UILabel!
    @IBOutlet weak var availabelTitleLabel: UILabel!
    @IBOutlet weak var change24hTitleLabel: UILabel!
    
    @IBOutlet weak var priceUsdLabel: UILabel!
    @IBOutlet weak var change1hLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volume24hLabel: UILabel!
    @IBOutlet weak var availabelSupplyLabel: UILabel!
    @IBOutlet weak var change24hLabel: UILabel!
    
    @IBOutlet weak var buyCoinButton: UIButton!
    @IBOutlet weak var sellCoinButton: UIButton!
    @IBOutlet weak var addToAlfolioButton: UIButton!
    
    var priceUsd:  String?
    var change1h:  String?
    var marketCap: String?
    var volume24h: String?
    var available: String?
    var change24h: String?
    var coinName:  String?
    var coinImageName: String?
    var titleNav: NSAttributedString?
    
    var marketToday = ["Today", "1W", "1M", "3M", "6M", "1Y", "ALL"]
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    func customUI() {
        // custom uinavigationItem: titleView
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 30))
        let label = UILabel(frame: CGRect(x: 25, y: 10, width: 158, height: 20))
    
        label.font = UIFont(name: description, size: 15)
        label.attributedText = self.titleNav
        let image = UIImageView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        image.image = UIImage(named: self.coinImageName!)
        view.addSubview(label)
        view.addSubview(image)
        self.navigationItem.titleView = view
        // custom title color of uibackbarbutton
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        // custom UILabel
        let today = MyUI.customColour(red: 190, green: 190, blue: 190, str: " today", fontName: nil, size: nil)
        let price = MyUI.customColour(red: 120, green: 188, blue: 85, str: "+\(String(describing: self.priceUsd!))%", fontName: nil, size: nil)
        
        let combineTodayAndPrice = NSMutableAttributedString()
        combineTodayAndPrice.append(price)
        combineTodayAndPrice.append(today)
        
        self.change1hLabel.attributedText = combineTodayAndPrice
        
        self.priceUsdLabel.text = self.priceUsd
        self.availabelSupplyLabel.text = available
        self.volume24hLabel.text = self.volume24h
        self.marketCapLabel.text = self.marketCap
        
        if Double(self.change24h!)! < 0 {
            self.change24hLabel.text = "\(String(describing: change24h!))%"
            self.change24hLabel.textColor = UIColor(red: 246/255, green: 60/255, blue: 66/255, alpha: 1)
        } else {
            self.change24hLabel.text = "+\(String(describing: change24h!))%"
            self.change24hLabel.textColor = UIColor(red: 120/255, green: 188/255, blue: 85/255, alpha: 1)
        }
        self.marketCapLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        self.availabelSupplyLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        self.volume24hLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        
        self.volume24hrTitleLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        self.change24hTitleLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        self.marketCapTitleLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        self.availabelTitleLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        self.statsLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        self.priceUsdLabel.textColor = UIColor(red: 240/255, green: 108/255, blue: 84/255, alpha: 1)
        // custom UIButon
        let buyString = MyUI.customColour(red: 203, green: 222, blue: 180, str: "BUY", fontName: nil, size: nil)
        let name1String = MyUI.customColour(red: 120, green: 188, blue: 85, str: " \(String(describing: self.coinName!.uppercased()))", fontName: nil, size: nil)
        let combine = NSMutableAttributedString()
        combine.append(buyString)
        combine.append(name1String)
        self.buyCoinButton.setAttributedTitle(combine, for: .normal)
        
        let sellString = MyUI.customColour(red: 228, green: 176, blue: 164, str: "SELL", fontName: nil, size: nil)
        let name2String = MyUI.customColour(red: 240, green: 108, blue: 84, str: " \(String(describing: self.coinName!.uppercased()))", fontName: nil, size: nil)
        let combine1 = NSMutableAttributedString()
        combine1.append(sellString)
        combine1.append(name2String)
        self.sellCoinButton.setAttributedTitle(combine1, for: .normal)
        
        let addString = MyUI.customColour(red: 172, green: 192, blue: 196, str: "ADD TO", fontName: nil, size: nil)
        let name3String = MyUI.customColour(red: 81, green: 153, blue: 172, str: " ALTFOLIO", fontName: nil, size: nil)
        let combine2 = NSMutableAttributedString()
        combine2.append(addString)
        combine2.append(name3String)
        self.addToAlfolioButton.setAttributedTitle(combine2, for: .normal)
        
        customButton(button: self.buyCoinButton)
        customButton(button: self.addToAlfolioButton)
        customButton(button: self.sellCoinButton)
        
        self.tableView.separatorColor = UIColor.lightGray
        self.tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marketToday.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionID", for: indexPath) as! CaseCollectionViewCell
        cell.contentLabel.text = marketToday[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CaseCollectionViewCell
        cell.contentLabel.textColor = UIColor(red: 120/255, green: 188/255, blue: 85/255, alpha: 1)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CaseCollectionViewCell
        cell.contentLabel.textColor = UIColor.black
    }
    func customButton(button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        
    }
}

extension String {
}
