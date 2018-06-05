//
//  PlaylistsViewController.swift
//  MusicPlayer
//
//  Created by okura on 2018/01/19.
//  Copyright © 2018年 kay00000. All rights reserved.
//

import UIKit

class PlaylistsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView === self.playlistPicker {
            return 1
        } else if pickerView === self.musicPicker {
            return 1
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === self.playlistPicker {
            return self.playlists.count
        } else if pickerView === self.musicPicker {
            return self.currentSongList.count
        } else {
            return 1
        }
    }
    

    //MARK: - privateプロパティ
    private let musicDataController = MusicDataController.shared
    private var playlists: Array<PlaylistItem> = []
    private var currentSongList: Array<SongItem> = []
    private var currentPlaylistId: Int = 0
    private var selectedSongId: Int = 0
    
    private var songChanged: Bool = false
    
    @IBOutlet weak var playlistPicker: UIPickerView!
    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var sortTypeControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var elements = ["playlist1","playlist2","playlist3","playlist4","playlist5","playlist6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        self.playlists = musicDataController.getPlaylists(sortType: MusicDataController.SortType.DEFAULT, sortOrder: MusicDataController.SortOrder.ASCENDING)
        
        let nib = UINib(nibName:"PlaylistTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "PlaylistCell")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("ViewController")
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for:indexPath) as! PlaylistTableViewCell
//        for playlist:PlaylistItem in self.playlists{
//            print("\(playlist.id):\(playlist.title)")
//        }

        if(self.playlists[indexPath.row].artwork == nil) {
            cell.commonInit(nil, title: self.playlists[indexPath.row].title)
        }else{
            cell.commonInit(self.playlists[indexPath.row].artwork!, title:self.playlists[indexPath.row].title)
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * 各indexPathのcellの高さを指定します．
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SongTable = SongsViewController()
        self.navigationController?.pushViewController(SongTable, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func setPlaylist() {
        self.playlists = musicDataController.getPlaylists(sortType: MusicDataController.SortType.TITLE, sortOrder: MusicDataController.SortOrder.ASCENDING)
        
        self.playlistPicker.delegate = self
        self.playlistPicker.dataSource = self
        
        self.playlistPicker.selectRow(0, inComponent: 0, animated: true)
        
        self.currentPlaylistId = self.playlists[self.currentPlaylistId].id
        
        self.setMusicFromPlaylist(playlistId: self.currentPlaylistId)
    }
    
    func setMusicFromPlaylist(playlistId: Int) {
        let sortType:MusicDataController.SortType = musicDataController.SortTypeListSong[self.sortTypeControl.selectedSegmentIndex]
        
//        let test = musicDataController.getPlayingHistory()
        
        //プレイリスト内の曲の取得
        self.currentSongList = musicDataController.getSongsWithPlaylist(id: playlistId, sortType: sortType)
        
        self.musicPicker.dataSource = self
        self.musicPicker.delegate = self
        
        self.selectedSongId = 0
        self.musicPicker.selectRow(0, inComponent: 0, animated: true)
        
        songChanged = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
