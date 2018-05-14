//
//  CoinDetailViewController.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/25/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import UIKit

class CoinDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var content = ["Today", "1W", "1M", "3M", "6M", "1Y", "All"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CaseCollectionViewCell
        cell.contentLabel.text = content[indexPath.row]
        return cell
    }
}
