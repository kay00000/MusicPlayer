//
//  PlaylistTableViewCell.swift
//  MusicPlayer
//
//  Created by tpj-design on 2018/03/06.
//  Copyright © 2018年 kay00000. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var playlistArtWork:  UIImageView!
    
    @IBOutlet weak var playlistTitle: UILabel!
    
    override init (style:UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.addSubview(playlistArtWork)

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ imageName: String, title: String){
//        playlistArtWork.image = UIImage(named: imageName)
        print(title)
        self.playlistTitle?.text = title
    }
    
}
