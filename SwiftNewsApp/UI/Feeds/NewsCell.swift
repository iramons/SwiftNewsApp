//
//  NewsCell.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import UIKit

class NewsCell: BaseTableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ivNews: UIImageView!
    @IBOutlet weak var lblPublishedAt: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ivNews.kf.cancelDownloadTask()
        ivNews.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
