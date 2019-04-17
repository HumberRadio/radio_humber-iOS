//
//  AboutUsViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/14/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import MaterialComponents.MDCBaseCell
import RZTransitions


class AboutUsViewController: UIViewController {

    @IBOutlet weak var topNavigationBar: UINavigationBar!
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    
    //helper UI
    private var finishedLoadingInitialTableCells = false
    
    // Data
    var teamMemberList:[TeamMember] = [TeamMember]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backUIBar = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
        topNavigationItem.leftBarButtonItem = backUIBar
        let teamMember = TeamMember.init()
        teamMemberList = teamMember.getDummyData()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func backTapped(){
        self.dismiss(animated: true, completion: nil)
    }
}

//*****************************************************************
// MARK: - TableViewDelegate
//*****************************************************************

extension AboutUsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        var memberUrl = URL.init(string: URLConstants.Domains.alexURL)
        
        switch indexPath.row {
        case 0:
            memberUrl = URL.init(string: URLConstants.Domains.alexURL)
            break;
        case 1:
            memberUrl = URL.init(string: URLConstants.Domains.deanURL)
            break;
        case 2:
            memberUrl = URL.init(string: URLConstants.Domains.kayleeURL)
            break;
        case 3:
            memberUrl = URL.init(string: URLConstants.Domains.noahURL)
            break;
        case 4:
            memberUrl = URL.init(string: URLConstants.Domains.febaURL)
            break;
        case 5:
            memberUrl = URL.init(string: URLConstants.Domains.jaspreetURL)
            break;
        case 6:
            memberUrl = URL.init(string: URLConstants.Domains.tajURL)
            break;
        default:
            memberUrl = URL.init(string: URLConstants.Domains.alexURL)
            break;
        }
        
        UIApplication.shared.open(memberUrl!, options: [:], completionHandler: nil)
        
    }
}

//*****************************************************************
// MARK: - TableViewDataSource
//*****************************************************************

extension AboutUsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMemberList.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if teamMemberList.isEmpty {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NothingFound", for: indexPath)
//            cell.backgroundColor = .clear
//            cell.selectionStyle = .none
//            return cell
//
//        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberCell", for: indexPath) as! TeamMemberTableViewCell
            
            // alternate background color
            cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.1)
            
            let teamMember = self.teamMemberList[indexPath.row]
            //bond ui view with data
            cell.configureTeamMemberCell(teamMember: teamMember)
            
            return cell
//        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        var lastInitialDisplayableCell = false
        //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
        if self.teamMemberList.count > 0 && !finishedLoadingInitialTableCells {
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
            
            UIView.animate(withDuration: 0.5, delay: 0.12*Double(indexPath.row+1), options: [.curveEaseOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
}

