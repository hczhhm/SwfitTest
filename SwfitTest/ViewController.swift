//
//  ViewController.swift
//  SwfitTest
//
//  Created by 51dgwmac1 on 2017/12/26.
//  Copyright © 2017年 51DGW. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
var label :UILabel!
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "测试"
//        label = UILabel.init(frame: CGRect(x:30,y:64+30,width:50,height:35))
////        label = UILabel.init()
//        label.textColor = UIColor.black
//        label.text = "label"
//        self.view.addSubview(label)
//
//        let btn = UIButton.init(frame: CGRect(x:30,y:label.frame.size.height+label.frame.origin.y,width:50,height:35))
//
//        btn.setTitle("点击", for: UIControlState.normal);
//        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
//        btn.addTarget(self, action:#selector(clickAction(button:)), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(btn);

//
//        let imageView = UIImageView.init(frame: CGRect(x:30,y:btn.frame.size.height+btn.frame.origin.y+30,width:50,height:50))
//        let imageView = UIImageView.init()
//        imageView.image = UIImage.init(named: "Personal_c")
//        imageView.layer.cornerRadius = 10;
//        imageView.layer.masksToBounds = true;
//        self.view.addSubview(imageView);
        
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        self.loadData()
    }

//    lazy var label:UILabel = {
//        let rect:CGRect = CGRect(x:30,y:50,width:50,height:30);
//        var label = UILabel.init(frame: rect);
//        return label;
//    }
    
    func loadData() -> Void {
//         //数组转json字符串
//        let companyIdsJsonList = NSArray.init()
//        let comdata = try? JSONSerialization.data(withJSONObject: companyIdsJsonList, options:JSONSerialization.WritingOptions.init(rawValue: 0))
//        let companyIdsJson = NSString(data: comdata!, encoding: String.Encoding.utf8.rawValue)
//
//        let statusJsonList = ["2"]
//        let data = try? JSONSerialization.data(withJSONObject: statusJsonList, options:JSONSerialization.WritingOptions.init(rawValue: 0))
//        let statusJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
//        let  param = [
//            "userId" : "f52e3d382d6a49a2bc331a8ede3ace93",
//        ]
        let parameters:Dictionary = ["userId":"f52e3d382d6a49a2bc331a8ede3ace93"]
        Alamofire.request("http://116.62.61.210/v1/api/company/getCompanyList", method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: nil).responseJSON { response in
            if response.error == nil{
                print("response: \(response)")
                print("result: \(response.result)")
                if let value = response.result.value {
                    self.infoJson = JSON(value)
                    self.infoList = self.infoJson["data"].array! as NSArray
                    [self.tableView .reloadData()];
                }
                
            }else{
                
            }
            
        }
        
    }
    //懒加载
    lazy var tableView:UITableView = {
        //        let tableView = UITableView.init(frame: CGRect(x:0,y:64,width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height))
        let tableView = UITableView.init(frame:CGRect.init(), style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self;
        tableView.dataSource = self;
        
        return tableView
        
    }()
    lazy var infoJson:JSON = {
        let json = JSON.init()
        return json;
        
    }()
    lazy var infoList:NSArray = {
        let infoList = NSArray.init()
        return infoList;
        
    }()
    @objc func clickAction(button:UIButton) -> Void {
         self.loadData()
    
    }
//MARK: tableview
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows = self.infoJson["data"][section]["companyList"]
        return rows.count;
    }
    public func numberOfSections(in tableView: UITableView) -> Int{
        return self.infoList.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer  = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer)
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifer)
        }
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
      
        cell?.textLabel?.text = self.infoJson["data"][indexPath.section]["companyList"][indexPath.row]["companyName"].string
        return cell!
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView.init()
    headerView.backgroundColor = UIColor .lightGray
    let label = UILabel.init(frame: CGRect.init(x: 30, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
    label.textColor = UIColor.red
    label.text = self.infoJson["data"][section]["cityName"].string
    label.font = UIFont.systemFont(ofSize: 18)
    headerView.addSubview(label)
    
//        let label = UILabel.init(frame: CGRect(x:30,y:0,width:UIScreen.main.bounds.size.width,height:30)
//        view.addSubview(label)
      return headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

