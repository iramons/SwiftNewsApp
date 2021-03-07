//
//  BaseTableViewCell.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    var bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
