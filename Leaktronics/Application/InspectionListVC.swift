//
//  InspectionListViewController.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import SideMenu
import CoreData

class InspectionListVC: UIViewController {

    //MARK:- Variable Declaration
    @IBOutlet weak var vwInspectionList: UICollectionView!
    var imageArray = NSArray()
    var categoryText = NSArray()
    
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false    //This line is to stop from swapping back to prevoius view controller
        if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" { //done
            self.imageArray = ["Plumber_8s+","Pool_8s+","Inspection_8s+"]
        } else if UIDevice.current.screenType.rawValue == "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE" { //done
            self.imageArray = ["Plumber_SE","Pool_SE","Inspection_SE"]
        } else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS or iPhone 11 Pro" { //done
            self.imageArray = ["Plumber_11","Pool_11","Inspection_11"]
        } else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" { //done
            self.imageArray = ["Plumber_11Max","Pool_11Max","Inspection_11Max"]
        } else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max " { //done
            self.imageArray = ["Plumber_11Max","Pool_11Max","Inspection_11Max"]
        } else if UIDevice.current.userInterfaceIdiom == .phone {
            self.imageArray = ["category1","category2","category3"]
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.imageArray = ["category1_iPad","category2_iPad","category3_iPad"]
        }
        
        self.categoryText = ["Plumbing Leak Detection","Swimming Pool Leak Detection","Pool Inspection with Leak Detection"]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        //addSlideMenuButton("InspectionListViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.askForSync()
    }
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    //MARK:- Function
    func askForSync() {
        if #available(iOS 10.0, *) {
            let group = DispatchGroup()
                
            group.enter()
            SharedFunctions.postPlumberLeak {
                print("PlumberLeak Done")
            }
            group.leave()
            
            group.enter()
            SharedFunctions.postPoolLeak {
                print("PoolLeak Done")
            }
            group.leave()
        
            group.enter()
            SharedFunctions.postInspectionPool {
                print("InspectionPool Done")
            }
            group.leave()
            
            group.notify(queue: DispatchQueue.global(qos: .background)) {
                print("All async calls were run!")
            }
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//
//            //TODO:: PlumberLeak_CoreData
//            // Create Fetch Request
//            let requestPlumber = NSFetchRequest<NSFetchRequestResult>(entityName: "PlumberLeak_CoreData")
//
//            // Helpers
//            var arrPlumber = NSArray()
//
//            do {
//                // Execute Fetch Request
//                let result = try context.fetch(requestPlumber)
//                if let records = result as? [NSManagedObject] {
//                    arrPlumber = records as NSArray
//                    print("PlumberLeak_CoreData is :\(arrPlumber.count)")
//                }
//            } catch {
//                print("Unable to fetch managed objects for entity PlumberLeak_CoreData.")
//            }
//
//            //TODO:: PoolDetection_CoreData
//            // Create Fetch Request
//            let requestPool = NSFetchRequest<NSFetchRequestResult>(entityName: "PoolDetection_CoreData")
//
//            // Helpers
//            var arrPool = NSArray()
//
//            do {
//                // Execute Fetch Request
//                let result = try context.fetch(requestPool)
//                if let records = result as? [NSManagedObject] {
//                    arrPool = records as NSArray
//                    print("PoolDetection_CoreData is :\(arrPool.count)")
//                }
//            } catch {
//                print("Unable to fetch managed objects for entity PoolDetection_CoreData.")
//            }
//
//            //TODO:: InspectionPool_CoreData
//            // Create Fetch Request
//            let requestInspect = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionPool_CoreData")
//
//            // Helpers
//            var arrInspect = NSArray()
//
//            do {
//                // Execute Fetch Request
//                let result = try context.fetch(requestInspect)
//                if let records = result as? [NSManagedObject] {
//                    arrInspect = records as NSArray
//                    print("InspectionPool_CoreData is :\(arrInspect.count)")
//                }
//            } catch {
//                print("Unable to fetch managed objects for entity InspectionPool_CoreData.")
//            }
//
//            if arrPlumber.count > 0 || arrPool.count > 0 || arrInspect.count > 0 {
//                //Present the AlertController
//                self.present(actionSheetController, animated: true, completion: nil)
//            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InspectionListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:- Bottleshop Collection View Delegate/Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspectionList", for: indexPath) as! InspectionListCollectionViewCell
        
        cell.vwInspectionCategoryImage.image = UIImage(named: (self.imageArray[indexPath.item] as? String)!)
        //cell.vwInspectionCategoryImage.sizeToFit()
        //cell.vwInspectionCategoryImage.clipsToBounds = true
        //cell.lblInspectionCategoryName.text = self.categoryText[indexPath.item] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let width = (self.vwInspectionList.frame.size.width - 40)
            let height = (self.vwInspectionList.frame.size.height - 90)/3
            print(self.vwInspectionList.frame.size.height)
            print(height)
            return CGSize(width: width, height:  height)
        } else { //UIDevice.current.userInterfaceIdiom == .pad
            let width = (self.vwInspectionList.frame.size.width - 90)
            print(width)
            let height = (self.vwInspectionList.frame.size.height - 60)/3
            print(self.vwInspectionList.frame.size.height)
            print(height)
            return CGSize(width: width, height:  height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(false, forKey: "isFromReportList")
        if indexPath.row == 0 {
             if UIDevice.current.userInterfaceIdiom == .phone {
                 let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                 let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                 self.navigationController?.pushViewController(nextVC, animated: true)
             } else { //UIDevice.current.userInterfaceIdiom == .pad
                 let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                 let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                 self.navigationController?.pushViewController(nextVC, animated: true)
             }
         } else  if indexPath.item == 1 {
             if UIDevice.current.userInterfaceIdiom == .phone {
                 let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                 let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                 //let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetect") as! PoolDetectVC
                 self.navigationController?.pushViewController(nextVC, animated: true)
             } else { //UIDevice.current.userInterfaceIdiom == .pad
                 let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                 let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                 self.navigationController?.pushViewController(nextVC, animated: true)
             }
        } else  if indexPath.item == 2 {
             if UIDevice.current.userInterfaceIdiom == .phone {
                 let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                 let nextVC = storyBoard.instantiateViewController(withIdentifier: "InspectPoolContact") as! InspectPoolContactVC
                 self.navigationController?.pushViewController(nextVC, animated: true)
             } else { //UIDevice.current.userInterfaceIdiom == .pad
                 let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                 let nextVC = storyBoard.instantiateViewController(withIdentifier: "InspectPoolContact") as! InspectPoolContactVC
                 self.navigationController?.pushViewController(nextVC, animated: true)
             }
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 20.0
        } else { //UIDevice.current.userInterfaceIdiom == .pad
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
