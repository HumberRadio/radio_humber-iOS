//
//  TransportationViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/19/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit

class TransportationViewController: UIViewController {
    @IBOutlet weak var topNavigationBar: UINavigationBar!
    
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    
    
    //helper UI
    private var finishedLoadingInitialTableCells = false
    private var dateCellExpanded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backUIBar = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
        topNavigationItem.leftBarButtonItem = backUIBar
        // Do any additional setup after loading the view.
    }
    @objc func backTapped(){
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
    
    //*****************************************************************
    // MARK: - TableViewDelegate
    //*****************************************************************
}
    extension TransportationViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                if dateCellExpanded {
                    dateCellExpanded = false
                } else {
                    dateCellExpanded = true
                }
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 0 {
                if dateCellExpanded {
                    return 250
                } else {
                    return 50
                }
            }
            return 50
        }
        
      
    }
    
    //*****************************************************************
    // MARK: - TableViewDataSource
    //*****************************************************************
    
    extension TransportationViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
//            if teamMemberList.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NothingFound", for: indexPath)
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                return cell
//

        }
      
        
        
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 80.0
//        }
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            var lastInitialDisplayableCell = false
            //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
//            if self.teamMemberList.count > 0 && !finishedLoadingInitialTableCells {
//                if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
//                    let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
//                    lastInitialDisplayableCell = true
//                }
//            }
//
//            if !finishedLoadingInitialTableCells {
//
//                if lastInitialDisplayableCell {
//                    finishedLoadingInitialTableCells = true
//                }
//
//                //animates the cell as it is being displayed for the first time
//                cell.transform = CGAffineTransform(translationX: 0, y: CGFloat(90/2))
//                cell.alpha = 0
//
//                UIView.animate(withDuration: 0.5, delay: 0.12*Double(indexPath.row+1), options: [.curveEaseOut], animations: {
//                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
//                    cell.alpha = 1
//                }, completion: nil)
//            }
        }
}



