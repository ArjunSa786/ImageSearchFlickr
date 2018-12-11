//
//  PhotosTableViewCell.swift
//  FlickrImageSearch
//


import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var m_titleLabel: UILabel!
    @IBOutlet weak var m_bgblurImageView: UIImageView!
    @IBOutlet weak var m_flickrImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(result: Photo) {
        m_titleLabel.text = result.title
        let photourl = "http://farm" + String(result.farm) + ".static.flickr.com/" + result.server + "/"
        let fullPhotoURL = photourl + result.id + "_" + result.secret + ".jpg"
        m_flickrImageView.loadImageUsingCacheWithImageURLString(fullPhotoURL, placeHolder: UIImage(named:"placeholder")) { (bool) in

    }

    }
    
    
    
}
