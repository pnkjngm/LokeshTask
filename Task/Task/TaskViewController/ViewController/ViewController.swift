//
//  ViewController.swift
//  Task
//
//  Created by Vyas, Lokesh Kumar on 03/03/19.
//  Copyright © 2019 Vyas, Lokesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var topCategoryView:UIView!{
        didSet {
            topCategoryView.layer.borderWidth = 1.0
            topCategoryView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var topCategoryHeightConst:NSLayoutConstraint!
    
    fileprivate var offsetForTopCategories:CGFloat = 0
    fileprivate let heightForTopCategoryVew:CGFloat = 50

    // Data Setup
    lazy var mySections: [SectionData] = {
        let section1 = SectionData(title: "Section 1 : Cocoa.Pankaj", data: "Meal", "WorkOut", "Water", "Points", "Bonus")
        let section2 = SectionData(title: "Section 2 : PnkjNgm ", data: "Food", "Exercise", "Health", "Reard", "ETC")
        let section3 = SectionData(title: "Section 3 : BP_work", data: "Sleep", "WakeUp", "Bike", "Steam", "Run", "Get Ready")
        
        return [section1, section2,section3]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.offsetForTopCategories = self.tableView.rect(forSection: 0).size.height
        self.offsetForTopCategories -= heightForTopCategoryVew
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section].title
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySections[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTitle = mySections[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        cell.textLabel?.text = cellTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let position : CGPoint = cell.convert(.zero, to: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: position)
        {
            let section = indexPath.section
            print("will display section: \(section)")
        }
    }
    
}
extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            
            if scrollView.contentOffset.y >= offsetForTopCategories + heightForTopCategoryVew {
                self.topCategoryHeightConst.constant = heightForTopCategoryVew
                return
            }
            if scrollView.contentOffset.y >= offsetForTopCategories && scrollView.contentOffset.y <= offsetForTopCategories + heightForTopCategoryVew {
                self.topCategoryHeightConst.constant = scrollView.contentOffset.y - offsetForTopCategories
            } else {
                self.topCategoryHeightConst.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
}

