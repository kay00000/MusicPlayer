//
//  SongTableViewCell.swift
//  MusicPlayer
//
//  Created by okura on 2018/03/29.
//  Copyright © 2018年 kay00000. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songArtWork: UIImageView!
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var artistName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, １ animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ imageName: String, title: String){
        //        playlistArtWork.image = UIImage(named: imageName)
        print(title)
        self.songName?.text = title
    }
    
}
