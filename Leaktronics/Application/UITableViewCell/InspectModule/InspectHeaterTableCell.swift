//
//  InspectHeaterTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/9/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton


//MARK:- Heater
protocol HeatMainProtocol {
    func didTapOnCellHeatMain(_btnDescribeTag: Int)
}

class HeatMainTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var btn3: DLRadioButton!
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var tblSubVw: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    
    var delegateHeatMain: HeatMainProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateHeatMain?.didTapOnCellHeatMain(_btnDescribeTag: radioButton.tag)
    }
}
