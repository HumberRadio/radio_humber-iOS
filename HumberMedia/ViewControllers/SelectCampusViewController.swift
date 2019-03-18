//
//  SelectCampusViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/12/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialNavigationBar
import RZTransitions

class SelectCampusViewController: UIViewController {
    //UIObjects
    
   
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    private var finishedLoadingInitialTableCells = false
    
    private var campusList = [Campus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        
        let backUIBar = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
//        let playUIBar = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
         topNavigationItem.leftBarButtonItem = backUIBar
        var campustest = Campus(campusName: "test", longitute: -79.612143, latitute: 43.7344449 )
        campusList = campustest.loadDummyData()
        // Do any additional setup after loading the view.
    }
    @objc func backTapped()
    {
        self.dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//*****************************************************************
// MARK: - TableViewDelegate
//*****************************************************************

extension SelectCampusViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.transitioningDelegate = RZTransitionsManager.shared()
        let mapsViewController:CampusNavigationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CampusNavigationID") as! CampusNavigationViewController
        let nextViewController = mapsViewController
        nextViewController.transitioningDelegate = RZTransitionsManager.shared()
        self.present(nextViewController, animated:true)
    }
}

//*****************************************************************
// MARK: - TableViewDataSource
//*****************************************************************

extension SelectCampusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campusList.count
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if campusList.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NothingFound", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CampusCell", for: indexPath) as! CampusTableViewCell

            // alternate background color
            cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.1)

            let campus = self.campusList[indexPath.row]
            //bond ui view with data
            cell.configureCampusCell(campus: campus)

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
        if self.campusList.count > 0 && !finishedLoadingInitialTableCells {
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
            cell.transform = CGAffineTransform(translationX: 0, y: CGFloat(90/2))
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
}

