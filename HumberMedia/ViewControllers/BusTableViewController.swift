//
//  MainTableViewController.swift
//
// Copyright (c) 21/12/15. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import FoldingCell
import UIKit

class BusTableViewController: UITableViewController {

    var ttc927SouthBusses:Direction = Direction()
    var ttc927NorthBusses:Direction = Direction()
    var ttc96EastBusses:Direction = Direction()
    var ttc96WestBusses:Direction = Direction()
    var ttc36EastBusses:Direction = Direction()
    var ttc36WestBusses:Direction = Direction()
    
    enum Const {
        static let closeCellHeight: CGFloat = 179
        static let openCellHeight: CGFloat = 488
        static let rowsCount = 10
    }
    
    var cellHeights: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let ttc927South = BusParcer().parce927South()
        
        if ttc927South.count > 1 {self.ttc927SouthBusses = BusParcer().getTop3Busses(forDirection: ttc927South, busDirection: "South 927")}
        else {print("error parcing ttc responce South 927")}
        
        let ttc927North = BusParcer().parce927North()
        if ttc927North.count > 1 {self.ttc927NorthBusses = BusParcer().getTop3Busses(forDirection: ttc927North, busDirection: "North 927")}
        else {print("error parcing ttc responce North 927")}
        
        let ttc96East = BusParcer().parce96East()
        if ttc96East.count > 1 {self.ttc96EastBusses = BusParcer().getTop3Busses(forDirection: ttc96East, busDirection: "East 96")}
        else {print("error parcing ttc responce East 96")}
        
        let ttc96West = BusParcer().parce96West()
        if ttc96West.count > 1 {self.ttc96WestBusses = BusParcer().getTop3Busses(forDirection: ttc96West, busDirection: "West 96")}
        else {print("error parcing ttc responce West 96")}
        
        let ttc36East = BusParcer().parce36East()
        if ttc36East.count > 1 {self.ttc36EastBusses = BusParcer().getTop3Busses(forDirection: ttc36East, busDirection: "East 36")}
        else {print("error parcing ttc responce East 36")}
        
        let ttc36West = BusParcer().parce36West()
        if ttc36West.count > 1 {self.ttc36WestBusses = BusParcer().getTop3Busses(forDirection: ttc36West, busDirection: "West 36")}
        else {print("error parcing ttc responce West 36")}
        
        
        
        
        
        
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount )
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        
     //   tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "button_volume"))
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
        
//        var ttc927SouthList = XMLParserHelper().get927South()
   
        
        print("test")
    }
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            } 
            self?.tableView.reloadData()
        })
    }
}

// MARK: - TableView

extension BusTableViewController {

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as BusCell = cell else {
            return
        }
        // do ui preset here
        cell.backgroundColor = .clear

        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }


        // get data
//        self.ttc927SouthBusses
        
        // set data
        switch indexPath.row {
        case 0:
            cell.closeNumberLabel.text = self.ttc927SouthBusses.direction
            break;
        case 1:
            cell.closeNumberLabel.text = self.ttc36EastBusses.direction
            break;
        case 2:
            cell.closeNumberLabel.text = self.ttc96EastBusses.directionName
            break;
        default:
            break;
        }
//        cell.routeNumber = self.ttc927SouthBusses.directionName
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell

        if cell.isAnimating() {
            return
        }

        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}
