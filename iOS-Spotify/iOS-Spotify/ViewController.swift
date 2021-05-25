//
//  ViewController.swift
//  iOS-Spotify
//
//  Created by Ignatio Julian on 25/05/21.
//

import UIKit
import RxSwift
import Kingfisher
import SwiftOverlays

class ViewController: UIViewController {
    
    @IBOutlet weak var trackTableView: UITableView!
    
    var rowData: [Item] = []
    var nextPage: String? = nil
    var nextInt = 0
    var limitInt = 20
    var track = "Ardhito Pramono"
    var isSearch = false
    
    private var disposeBag = DisposeBag()
    private var trackService = TrackService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Juls Playlist"
        self.getDefaultTrack(track: track, offset: nextInt, limit: limitInt)
        self.trackTableView.delegate = self
        self.trackTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDefaultTrack(track: String, offset: Int, limit: Int) {
//        SwiftOverlays.showBlockingWaitOverlay()
        trackService
            .getTrackByQuery(parameters: ConvertString().toPlusString(text: track), offset: offset, limit: limit)
            .subscribe(
                onNext: { trackResponse in
                    if offset == 0 && trackResponse.tracks?.items?.count != 0 {
                        self.rowData.removeAll()
                    }
                    if trackResponse.tracks?.items?.count != 0 {
                        self.rowData.append(contentsOf: (trackResponse.tracks?.items)!)
                        if ((trackResponse.tracks?.next) ?? "").isEmpty == false {
                            self.nextPage = (trackResponse.tracks?.next)!
                        } else {
                            self.nextPage = nil
                        }
                        self.nextInt = (trackResponse.tracks?.offset)! + 20
                        self.trackTableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Info", message: "Maaf, Data Tidak ditemukan :(", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
//                    SwiftOverlays.removeAllBlockingOverlays()
                },
                onError: { error in
//                    SwiftOverlays.removeAllBlockingOverlays()
                }
            )
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.rowData.count - 1) {
            if (self.nextPage ?? "").isEmpty == false {
                self.getDefaultTrack(track: track, offset: nextInt, limit: 20)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TrackTableViewCell", owner: self, options: nil)?.first as! TrackTableViewCell
        
        cell.titleLabel.text = self.rowData[indexPath.row].name
        cell.ArtistLabel.text = ConvertString().arrayArtistToString(array: self.rowData[indexPath.row].artists!)
        cell.AlbumLabel.text = self.rowData[indexPath.row].album?.name
        
        let url = URL(string: (self.rowData[indexPath.row].album?.images?[0].url)!)
        cell.imageView?.setImage(with: url!.path)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}


