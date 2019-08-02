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
    var lat = 1.0
    var lon = 1.0
    
    override var preferredStatusBarStyle:UIStatusBarStyle {
        return UIStatusBarStyle.lightContent //상태표시줄 색상 흰색
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(lat)
        print(lon)
        
        let StretchyTable = StretchyTableController()
        self.addChild(StretchyTable)
        //윗 부분 여백을 없애기 위한 좌표 지정
        StretchyTable.tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(StretchyTable.tableView)
        
        //collectionView 셀 속성 지정
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //간격 조정
        layout.sectionInset = .init(top: 5, left: 10, bottom: 5, right: 10)
        layout.itemSize = CGSize(width: 65 , height: 110)
        layout.scrollDirection = .horizontal
        
        //collectionView 변수 할당 및 설정
        let collection:UICollectionView = UICollectionView(frame:CGRect(x: 0, y: 360, width: view.frame.width, height: 120),collectionViewLayout: layout)
        let cellNibs = UINib.init(nibName: "CollectionCell", bundle: nil)
        collection.register(cellNibs, forCellWithReuseIdentifier: "CollectionCell")
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.init(netHex: 0x4aa8d8)
        view.addSubview(collection)
        
        //UIView 변수 할당 및 설정
        let testUIView = UIView()
        testUIView.backgroundColor = UIColor.init(netHex: 0x4aa8d8)
        testUIView.contentMode = .scaleToFill
        testUIView.clipsToBounds = true
        testUIView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 359)
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 735, width: view.frame.width, height: 55)
        let transButton = UIBarButtonItem(title: "재설정", style: .plain, target: self, action: #selector(reselectLocation))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,transButton], animated: false)
        toolbar.barTintColor = testUIView.backgroundColor
            toolbar.tintColor = .white
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.lightText.cgColor
        toolbar.layer.addSublayer(topBorder)
        
        view.addSubview(toolbar)
        
        /////UILabel 코드로 설정
        let TextMain = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 50))
        TextMain.text = "인천광역시"
        TextMain.textColor = .white
        TextMain.shadowColor = .gray
        TextMain.font = .systemFont(ofSize: 30, weight: .semibold)
        
        let mainDescription = UILabel(frame: CGRect(x: 0, y: 140, width: view.frame.width, height: 30))
        mainDescription.text = "대체로 맑음"
        mainDescription.textColor = .white
        mainDescription.shadowColor = .gray
        mainDescription.font = .systemFont(ofSize: 15, weight: .medium)
        
        let tempo = UILabel(frame: CGRect(x: 0, y: 170, width: view.frame.width, height: 100))
        tempo.text = "34º"
        tempo.textColor = .white
        tempo.shadowColor = .gray
        tempo.font = .systemFont(ofSize: 90, weight: .thin)
        
        let dayLabel = UILabel(frame: CGRect(x: 20, y: 315, width: 55, height: 30))
        dayLabel.text = "금요일"
        dayLabel.textColor = .white
        dayLabel.shadowColor = .gray
        dayLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        let todayLabel = UILabel(frame: CGRect(x: 80, y: 316, width: 55, height: 30))
        todayLabel.text = "오늘"
        todayLabel.textColor = .white
        todayLabel.shadowColor = .gray
        todayLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        let minTempo = UILabel(frame: CGRect(x: 325, y: 315, width: 55, height: 30))
        minTempo.text = "25"
        minTempo.textColor = .lightText
        minTempo.font = .systemFont(ofSize: 20, weight: .medium)
        
        let maxTempo = UILabel(frame: CGRect(x: 275, y: 315, width: 55, height: 30))
        maxTempo.text = "34"
        maxTempo.textColor = .white
        maxTempo.font = .systemFont(ofSize: 20, weight: .medium)
        
        testUIView.addSubview(TextMain)
        testUIView.addSubview(mainDescription)
        testUIView.addSubview(tempo)
        testUIView.addSubview(dayLabel)
        testUIView.addSubview(todayLabel)
        testUIView.addSubview(minTempo)
        testUIView.addSubview(maxTempo)
        TextMain.textAlignment = .center
        mainDescription.textAlignment = .center
        tempo.textAlignment = .center
        
        view.addSubview(testUIView)
        
        //top 경계선
        let separatorLine = UIView()
        separatorLine.frame = CGRect(x: 0, y: 359.5, width: view.frame.width, height: 0.5)
        separatorLine.backgroundColor = .lightText
        view.addSubview(separatorLine)
        
        //bottom 경계선
        let separatorLineB = UIView()
        separatorLineB.frame = CGRect(x: 0, y: 479.5, width: view.frame.width, height: 0.5)
        separatorLineB.backgroundColor = .lightText
        view.addSubview(separatorLineB)
        
        //tableViewController에 추가
        StretchyTable.StUIView = testUIView
        StretchyTable.StcollectionView = collection
        StretchyTable.separator = separatorLine
        StretchyTable.separatorB = separatorLineB
    }

    //화면전환
    @objc func reselectLocation(){
        performSegue(withIdentifier: "Search", sender: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        if (indexPath.row+1)%2 == 1{
            cell.backgroundColor = .clear
            cell.weatherImage?.image = UIImage(named: "icons8-light-snow-50")
        }
        else if (indexPath.row+1)%2 == 0{
            cell.backgroundColor = .clear
            cell.weatherImage?.image = UIImage(named: "icons8-light-snow-50")
        }
        else{}
        return cell
    }
}

