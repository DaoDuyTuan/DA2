//
//  ViewController.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/20/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    
    @IBOutlet weak var bottomViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var leadingTableView: NSLayoutConstraint!
    @IBOutlet weak var bottomTableView: NSLayoutConstraint!
    @IBOutlet weak var priceUsdLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var countCoinRowLabel: UILabel!
    @IBOutlet weak var coinTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sortCoin: UIButton!
    var imageTextField: UIImageView!
    
    var checkSearch = false
    var list = CoinList()
    var coin: [Coin] {
        if !self.checkSearch {
            return self.list.coinList
        }
        return self.list.coinSetSearching
    }
    var formatter: NumberFormatter?
    var selectedCellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTextField = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        self.searchTextField.delegate = self
        list.getCoin(tableView: coinTableView)
        setLayout()
        
        print("dao duy tuan")
        print("dao duy tuan")
        print("dao duy tuan")
        print("dao duy tuan")
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        checkEdited()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.list.coinSetSearching = self.list.coinList
        checkEdited()
        textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchTextField.text = ""
        textField.resignFirstResponder()
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        self.list.searchCoin(text: self.searchTextField.text!, tableView: self.coinTableView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkEdited()
        return true
    }
    func checkEdited() {
        if !self.checkSearch, self.searchTextField.isEditing {
            self.imageTextField.image = UIImage(named: "close")
            self.checkSearch = true
        } else {
            imageTextField.image = UIImage(named: "search")
            self.searchTextField.endEditing(true)
            self.checkSearch = false
        }
        self.coinTableView.reloadData()
    }
    func setLayout() {
        // custom currency by NumberFormatter()
        formatter = NumberFormatter()
        formatter?.locale = Locale(identifier: "en-US")
        formatter?.numberStyle = .currency
        
        self.sortCoin.layer.borderWidth = 1
        self.sortCoin.layer.borderColor = UIColor(red: 244/255, green: 244/253, blue: 242/255, alpha: 1).cgColor
        self.searchTextField.backgroundColor = UIColor(red: 241/255, green: 242/255, blue: 244/255, alpha: 1)
        self.searchTextField.layer.cornerRadius = CGFloat(Float(10.0))
        
        var tapGesture = UITapGestureRecognizer()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSearch))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.searchTextField.frame.height))
        imageTextField.image = UIImage(named: "search")
        imageTextField.center = containerView.center
        containerView.addSubview(imageTextField)
        containerView.addGestureRecognizer(tapGesture)
        containerView.isUserInteractionEnabled = true
        self.searchTextField.leftView = containerView
        self.searchTextField.leftViewMode = UITextFieldViewMode.always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let cellIndexPath = self.selectedCellIndexPath {
            let view = UIView()
            view.backgroundColor = UIColor.white
            self.coinTableView.cellForRow(at: cellIndexPath)?.selectedBackgroundView = view
        }
        
        let titleLabel = UILabel()
        let attributedString1 = MyUI.customColour(red: 118, green: 169, blue: 77, str: "COIN", fontName: "RefuelExRg-Bold", size: 20.0)
        let attributedString2 = MyUI.customColour(red: 60, green: 73, blue: 81, str: "CAP", fontName: "RefuelExRg-Bold", size: 20.0)
        titleLabel.attributedText = MyUI.combineMultilString(str1: attributedString1, str2: attributedString2)
        self.navigationItem.titleView = titleLabel
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                print("SHOW")
                self.bottomViewHeightConstrain.constant = keyboardSize.height
                self.view.setNeedsLayout()
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        print("HIDE")
        self.bottomViewHeightConstrain.constant = 0.0
        self.view.setNeedsLayout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coin.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attr1 = MyUI.customColour(red: 218, green: 218, blue: 218, str: coin[indexPath.row].name!, fontName: nil, size: nil)
        let attr2 = MyUI.customColour(red: 170, green: 170, blue: 170, str: " \(coin[indexPath.row].symbol!)", fontName: nil, size: nil)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell") as! CoinTableViewCell
        cell.coinImageView.image = UIImage(named: coin[indexPath.row].symbol!)
        
        if cell.isSelected {
            let view = UIView()
            view.backgroundColor = UIColor.white
            cell.selectedBackgroundView = view
        }
        
        cell.coinNameLabel.attributedText = MyUI.combineMultilString(str1: attr1, str2: attr2)
        if let formatterCurrency = MyUI.formatterToCurrency(Double(coin[indexPath.row].priceUsd!)!){
            cell.priceUsd.text = formatterCurrency
        }
        cell.coinNumber.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCellIndexPath = indexPath
        let view = UIView()
        view.backgroundColor = UIColor(red: 253/255, green: 241/255, blue: 241/255, alpha: 1)
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView = view
        self.checkEdited() 
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.coin.count - 1, self.list.coiQtyWillAdd < 1000{
            self.loadMoreCoin()
        }
    }
    
    func loadMoreCoin() {
        list.getCoin(tableView: coinTableView)
    }
    
    @objc func handleSearch() {
        checkEdited()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        let rowSelected1 = coinTableView.indexPathForSelectedRow?.row
        let cell = self.coinTableView.cellForRow(at: self.coinTableView.indexPathForSelectedRow!) as! CoinTableViewCell
        if let coinDetail = segue.destination as? CoinDetailTableViewController, let rowSelected = rowSelected1  {
            
            coinDetail.available = numberFormatter.string(from: Double(coin[rowSelected].availableSupply!)! as NSNumber)
            coinDetail.change1h = coin[rowSelected].percentChange1h
            coinDetail.change24h = coin[rowSelected].percentChange24h
            coinDetail.priceUsd = MyUI.formatterToCurrency(Double(coin[rowSelected].priceUsd!)!)
            coinDetail.marketCap = MyUI.formatterToCurrency(Double(coin[rowSelected].marketCapUsd!)!)
            coinDetail.volume24h = MyUI.formatterToCurrency(Double(coin[rowSelected].volumeUsd24h!)!)
            coinDetail.coinName = coin[rowSelected].name
            coinDetail.coinImageName = coin[rowSelected].symbol
            coinDetail.titleNav = cell.coinNameLabel.attributedText
            
        }
    }
}
