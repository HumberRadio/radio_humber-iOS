//
//  AboutUsViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/14/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import MaterialComponents.MDCBaseCell

class AboutUsViewController: UIViewController {

    @IBOutlet weak var topNavigationBar: UINavigationBar!
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backUIBar = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
        topNavigationItem.leftBarButtonItem = backUIBar
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
extension AboutUsViewController:UICollectionViewDelegate
{
    
}
extension AboutUsViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutUsCell", for: indexPath) as! AboutUsCollectionViewCell
    collectionView.register(MDCBaseCell.self, forCellWithReuseIdentifier: "AboutUsCell")
        guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutUsCell", for: indexPath) as? MDCBaseCell else
        {
            fatalError()
        }
        
//        guard let cell1 = collectionView.cellForItem(at: indexPath) as? MDCBaseCell else {
//            fatalError()
//        }

      
        return cell2
//        guard let cell = collectionView.cellForItem(at: indexPath) as? MDCBaseCell else { fatalError() }
        
    }
    
    
}
