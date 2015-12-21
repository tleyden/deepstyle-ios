

import UIKit

class GalleryTableViewCell: UITableViewCell {
    
    @IBOutlet var paintingImageView: UIImageView? = nil
    @IBOutlet var photoImageView: UIImageView? = nil
    @IBOutlet var finishedImageView: UIImageView? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
