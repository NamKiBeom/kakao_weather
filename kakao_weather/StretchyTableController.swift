//
//  StretchyTableController.swift
//  kakao_weather
//
//  Created by 남기범 on 01/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit

class StretchyTableController: UITableViewController{
    var StcollectionView : UICollectionView? = nil
    var StUIView : UIView? = nil
    var separator : UIView? = nil
    var separatorB : UIView? = nil
    //2ac1bbe21fb06a301149057f64c0a926
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 430, left: 0, bottom: 0, right: 0)
        tableView.insetsContentViewsToSafeArea == false
        tableView.separatorStyle = .none
        
        //커스텀 테이블뷰를 구현하기 위한 수단
        //새로운 클래스를 만들어서 연결함
        let cellNib = UINib.init(nibName: "StretchyViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell1")
        let cellNib1 = UINib.init(nibName: "DiscriptionCell", bundle: nil)
        tableView.register(cellNib1, forCellReuseIdentifier: "DiscriptionCell")
        let cellNib2 = UINib.init(nibName: "EtcViewCell", bundle: nil)
        tableView.register(cellNib2, forCellReuseIdentifier: "EtcViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 5
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! StretchyViewCell
            cell.weather?.image = UIImage(named: "icons8-light-snow-50")
            return cell
        }
        else if indexPath.row == 5
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscriptionCell") as! DiscriptionCell
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EtcViewCell") as! EtcViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 5{
            return 30
        }
        else if indexPath.row == 5{
            return 70
        }
        else
        {
            return 65
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor = UIColor.init(netHex: 0x4aa8d8)
        scrollView.showsVerticalScrollIndicator = false
        let y = -scrollView.contentOffset.y//지정한 인셋의 값
        let height = max(270, y-120)
        
        //첫번째 헤더-스크롤시 높이 변화, 위치 고정
        StUIView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        separator?.frame = CGRect(x: 0, y: height-0.7, width: view.frame.width, height: 0.7)
        StcollectionView?.frame = CGRect(x: 0, y: height, width: view.frame.width, height: 119)
        separatorB?.frame = CGRect(x: 0, y: height+119.7, width: view.frame.width, height: 0.7)
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
