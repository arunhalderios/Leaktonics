//
//  InspectSummaryTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 29/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

class SummaryDataTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSummaryData: UITextView!
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSummaryData.layer.borderColor = UIColor.black.cgColor
        self.txtSummaryData.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSummaryData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSummaryData.layer.cornerRadius = 10
        }
    }
    
    
}

class DisclaimerTableCell: UITableViewCell,UITextViewDelegate {
    
    @IBOutlet weak var txtNote: UITextView!
    
    var callBack: ((UITextView) -> ())?
    
    //TODO:: View Lifecycle
   override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        txtNote.delegate = self
        txtNote.isScrollEnabled = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
           // tell controller the text changed
           callBack?(textView)
       }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
    
}
