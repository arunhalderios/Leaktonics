//
//  HelpSupportTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/18/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

class HelpTableCell: UITableViewCell {
    
    @IBOutlet weak var imagwHelp: UIImageView!
    @IBOutlet weak var lblHelp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

/*
class DisClaimerTableCell: UITableViewCell {
    @IBOutlet weak var lblDisClaimer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

/*class SearchTableCell: UITableViewCell {
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwSearch.layer.borderWidth = 1
        vwSearch.layer.borderColor = #colorLiteral(red: 0.5229148269, green: 0.5229148269, blue: 0.5229148269, alpha: 1)
        vwSearch.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}*/

class CustomFAQHeaderTableCell: UITableViewCell {
    @IBOutlet weak var lblFAQHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class CustomFAQTableCell: UITableViewCell {
    @IBOutlet weak var lblFAQTitle: UILabel!
    @IBOutlet weak var lblFAQContent: UILabel!
    @IBOutlet weak var btnFAQ: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class MessageTableCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSendMessage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIDevice.current.userInterfaceIdiom == .phone {
            btnSendMessage.layer.cornerRadius = 25
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            btnSendMessage.layer.cornerRadius = 38  
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
 */
