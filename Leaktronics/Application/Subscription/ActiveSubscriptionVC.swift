//
//  ActiveSubscriptionVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/11/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

class ActiveSubscriptionCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnCheck: UIButton!

    //TODO:: Variable Declaration
    var delegateSubScript: SubscriptionCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        innerView.layer.cornerRadius = 5
        innerView.clipsToBounds = true
        innerView.layer.shadowPath = UIBezierPath(rect: innerView.bounds).cgPath
        innerView.layer.shadowRadius = 5
        innerView.layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        innerView.layer.shadowOffset = .zero
        innerView.layer.shadowOpacity = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class PaymentCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnCheck: UIButton!

    //TODO:: Variable Declaration
    var delegateSubScript: SubscriptionCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class BackUpCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnCheck: UIButton!

    //TODO:: Variable Declaration
    var delegateSubScript: SubscriptionCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


class ActiveSubscriptionVC: UIViewController {
    
    @IBOutlet weak var tblActiveSubscript: UITableView!
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


extension ActiveSubscriptionVC: UITableViewDelegate, UITableViewDataSource {
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
