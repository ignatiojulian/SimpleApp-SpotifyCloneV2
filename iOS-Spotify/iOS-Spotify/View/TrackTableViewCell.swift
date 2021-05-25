//
//  TrackTableViewCell.swift
//  iOS-Spotify
//
//  Created by Ignatio Julian on 25/05/21.
//

import UIKit
import MarqueeLabel

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var AlbumImageView: UIView!
    @IBOutlet weak var titleLabel: MarqueeLabel!
    @IBOutlet weak var ArtistLabel: MarqueeLabel!
    @IBOutlet weak var AlbumLabel: MarqueeLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.titleLabel.type = .continuous
        self.titleLabel.speed = .duration(15)
        self.titleLabel.animationCurve = .easeInOut
        
        self.ArtistLabel.type = .continuous
        self.ArtistLabel.speed = .duration(15)
        self.ArtistLabel.animationCurve = .easeInOut
        
        self.AlbumLabel.type = .continuous
        self.AlbumLabel.speed = .duration(15)
        self.AlbumLabel.animationCurve = .easeInOut
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
