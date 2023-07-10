//
//  ViewController.swift
//  PaginationnTableView
//
//  Created by Mac on 09/07/23.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tblList: UITableView!
    var recordArray: [Int] = Array()
    var limit = 20
    let totalEnteries = 100
        

    override func viewDidLoad() {
        super.viewDidLoad()
        tblList.delegate = self
        tblList.dataSource = self
        tblList.tableFooterView = UIView(frame: .zero)
        
        var index = 0
        while index < limit  {
            recordArray.append(index)
            index = index + 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "listcell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "listcell")
        }
        cell?.textLabel?.text = "Row \(recordArray[indexPath.row])"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recordArray.count - 1 {
            //we need at last cell load more content
            if recordArray.count < totalEnteries {
                //we need to bring more records as there are some pending records availabel
                var index = recordArray.count
                limit = index + 20
                while index < limit  {
                    recordArray.append(index)
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
        }
    }
    @objc func loadTable (){
        self.tblList.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

