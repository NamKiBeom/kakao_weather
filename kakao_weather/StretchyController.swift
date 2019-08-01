//
//  StretchyController.swift
//  kakao_weather
//
//  Created by 남기범 on 01/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit

class StretchyController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    fileprivate let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        let StretchyTable = StretchyTableController()
        self.addChild(StretchyTable)
        //윗 부분 여백을 없애기 위한 좌표 지정
        StretchyTable.tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(StretchyTable.tableView)
        
        //collectionView 셀 속성 지정
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 65 , height: 120)
        layout.scrollDirection = .horizontal
        
        //collectionView 변수 할당 및 설정
        let collection:UICollectionView = UICollectionView(frame:CGRect(x: 0, y: 400, width: view.frame.width, height: 120),collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        view.addSubview(collection)
        
        //UIView 변수 할당 및 설정
        let testUIView = UIView()
        testUIView.backgroundColor = .black
        testUIView.contentMode = .scaleToFill
        testUIView.clipsToBounds = true
        testUIView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        view.addSubview(testUIView)
        
        //tableViewController에 추가
        StretchyTable.StUIView = testUIView
        StretchyTable.StcollectionView = collection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        if (indexPath.row+1)%2 == 1{
            cell.backgroundColor = .brown
        }
        else if (indexPath.row+1)%2 == 0{
            cell.backgroundColor = .blue
        }
        else{}
        return cell
    }
}
