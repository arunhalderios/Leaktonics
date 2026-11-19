//
//  PoolDetectVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 15/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

class PoolListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblPoolCategoryName: UILabel!
    @IBOutlet weak var lblArrow: UILabel!
    @IBOutlet weak var vwSelect: UIView!
}

class PoolDetectVC: UIViewController {
    
    //MARK:- Variable Declaration
    @IBOutlet weak var poolList: UICollectionView!
    var categoryText = NSArray()
    var selectIndex: Int = 0
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.categoryText = ["Contact", "Questionnaire Form 1", "Questionnaire Form 2", "Visual Leak", "Plumbing Statistic 1", "Plumbing Statistic 2"]
    }

}


extension PoolDetectVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:- Collection View Delegate/Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return categoryText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PoolListCell", for: indexPath) as! PoolListCollectionViewCell
        
        if indexPath.item == selectIndex {
            cell.lblPoolCategoryName.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            cell.vwSelect.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            cell.lblPoolCategoryName.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            cell.vwSelect.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        if indexPath.item == 5 {
            cell.lblArrow.isHidden = true
        } else {
            cell.lblArrow.isHidden = false
        }
        cell.lblPoolCategoryName.text = String(describing: self.categoryText[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex = indexPath.item
        self.poolList.reloadData()
//        if selectIndex == 0 {
//            self.poolList.reloadData()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.item == 0 {
                return CGSize(width: 100, height:  25)
            } else if indexPath.item == 3 {
                return CGSize(width: 130, height:  25)
            }  else if indexPath.item == 1 || indexPath.item == 2 {
                return CGSize(width: 220, height:  25)
            } else {
                return CGSize(width: 205, height:  25)
            }
        } else { //UIDevice.current.userInterfaceIdiom == .pad
            let width = (self.poolList.frame.size.width - 90)
            print(width)
            let height = (self.poolList.frame.size.height - 60)/3
            print(self.poolList.frame.size.height)
            print(height)
            return CGSize(width: width, height:  height)
        }
    }
}
