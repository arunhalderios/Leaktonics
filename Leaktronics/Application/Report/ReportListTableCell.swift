//
//  InspectionTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/30/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

//MARK:- All Module
class AllReportListTableCell: UITableViewCell {
    
    @IBOutlet weak var vwInner: UIView!
    @IBOutlet weak var lblReportName: UILabel!
    @IBOutlet weak var lblReportType: UILabel!
    @IBOutlet weak var lblReportAddress: UILabel!
    @IBOutlet weak var lblReportPh: UILabel!
    
    @IBOutlet weak var btnSendReport: UIButton!
    @IBOutlet weak var btnReportStatus: UIButton!
    
    //TODO:: Variable Declaration
    var delegatePhoneQuestionnaire: PhoneQuestionnaireProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwInner.layer.cornerRadius = 10
        vwInner.clipsToBounds = true
        vwInner.layer.shadowPath = UIBezierPath(rect: vwInner.bounds).cgPath
        vwInner.layer.shadowRadius = 5
        vwInner.layer.shadowOffset = .zero
        vwInner.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        vwInner.layer.shadowOpacity = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
