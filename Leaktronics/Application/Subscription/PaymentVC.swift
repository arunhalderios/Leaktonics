//
//  PaymentVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/11/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {
    
    @IBOutlet weak var tblPayment: UITableView!
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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



extension PaymentVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : ActiveSubscriptionCell = tableView.dequeueReusableCell(withIdentifier: "ActiveSubscriptionCell") as! ActiveSubscriptionCell
            return cell
        } else if indexPath.row == 1 {
            let cell : PaymentCell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell") as! PaymentCell
            return cell
        } else {
            let cell : BackUpCell = tableView.dequeueReusableCell(withIdentifier: "BackUpCell") as! BackUpCell
            return cell
        }
    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == 0 {
                return 265
            } else if indexPath.row == 1 {
                return 185
            } else {
                return 175
            }
        } else {
            return 225
        }
    }
}
