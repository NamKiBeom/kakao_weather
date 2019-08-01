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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.contentInset = UIEdgeInsets(top: 520, left: 0, bottom: 0, right: 0)
        tableView.insetsContentViewsToSafeArea == false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 15
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")!
        cell.textLabel?.text = "test"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = -scrollView.contentOffset.y//지정한 인셋의 값
        let height = max(150, y-120)
        //첫번째 헤더-스크롤시 높이 변화, 위치 고정
        StUIView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        //두번째 헤더-스크롤시 위치 변화, 높이 고정
        StcollectionView?.frame = CGRect(x: 0, y: height, width: view.frame.width, height: 120)
    }
}
