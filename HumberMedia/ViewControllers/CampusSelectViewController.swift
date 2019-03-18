//
//  CampusSelectViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/11/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit

class CampusSelectViewController: UIViewController {
    // MARK: - UIComponents
    
    @IBOutlet var tableView: UITableView!
    
    
//    // MARK: - Lists
    private var finishedLoadingInitialTableCells = false
    private var rowHeight = 100
//
    var searchedTracks = [Track]()
    var tracks = [Track]()
    
    // MARK: - UI
    
    var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    
    var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xmlparser = XMLParserHelper.init()
        self.tracks = xmlparser.parceRecentlyPlayed()
        

        // Do any additional setup after loading the view.
    }
}
    
    //*****************************************************************
    // MARK: - TableViewDelegate
    //*****************************************************************
    
extension CampusSelectViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "NowPlaying", sender: indexPath)
    }
}

//*****************************************************************
// MARK: - TableViewDataSource
//*****************************************************************

extension CampusSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if self.tracks.isEmpty {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "NothingFound", for: indexPath)
                        cell.backgroundColor = .clear
                        cell.selectionStyle = .none
                        return cell
            
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
            
                        // alternate background color
                        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.2)
            
                        let track = self.tracks[indexPath.item]
            //bond ui view with data
                        cell.configureSongCell(track: track)
            
                        return cell
    }
    }
    
    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    

    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if searchController.isActive {
//            return searchedStations.count
//        } else {
//            return stations.isEmpty ? 1 : stations.count
//        }
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if stations.isEmpty {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NothingFound", for: indexPath)
//            cell.backgroundColor = .clear
//            cell.selectionStyle = .none
//            return cell
//
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
//
//            // alternate background color
//            cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.2)
//
//            let station = searchController.isActive ? searchedStations[indexPath.row] : stations[indexPath.row]
//            cell.configureStationCell(station: station)
//
//            return cell
//        }
//    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        var lastInitialDisplayableCell = false
        //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
        if tracks.count > 0 && !finishedLoadingInitialTableCells {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                lastInitialDisplayableCell = true
            }
        }
        
        if !finishedLoadingInitialTableCells {
            
            if lastInitialDisplayableCell {
                finishedLoadingInitialTableCells = true
            }
            
            //animates the cell as it is being displayed for the first time
            cell.transform = CGAffineTransform(translationX: 0, y: CGFloat(self.rowHeight/2))
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
}

    

