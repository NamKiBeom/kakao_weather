//
//  StretchyController.swift
//  kakao_weather
//
//  Created by 남기범 on 01/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit
import Alamofire

struct clouds: Codable {
    var all: Int
}
struct coord: Codable {
    var lat: Double
    var lon: Double
}
struct main: Codable {
    var humidity: Int
    var pressure: Double
    var temp: Double
    var temp_max: Double
    var temp_min: Double
}
struct sys: Codable {
    var country: String
    var message: Double
    var sunrise: Int
    var sunset: Int
}
struct weather: Codable {
    var description: String
    var icon: String
    var id: Int
    var main: String
}
struct wind: Codable {
    var deg: Double
    var speed: Double
}
struct current: Codable {
    var base: String
    var clouds: clouds
    var cod: Int
    var coord: coord
    var dt: Int
    var id: Int
    var main: main
    var name: String
    var sys: sys
    var timezone: Int
    var weather: [weather]
    var wind: wind
}

struct city: Codable {
    var coord: coord
    var country: String
    var id: Int
    var name: String
    var timezone: Int
}
struct sysForecast: Codable {
    var pod: String
}
struct mainForecast: Codable {
    var grnd_level: Double
    var humidity: Int
    var pressure: Double
    var sea_level: Double
    var temp: Double
    var temp_kf: Double
    var temp_max: Double
    var temp_min: Double
}
struct list: Codable {
    var clouds: clouds
    var dt: Int
    var dt_txt: String
    var main: mainForecast
    var sys: sysForecast
    var weather: [weather]
    var wind: wind
}
struct forecast: Codable {
    var city: city
    var cnt: Int
    var cod: String
    var list: [list]
    var message: Double
}

var currentinfo = [current]()
var forecastinfo = [forecast]()
var 요약 = ""

class StretchyController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    fileprivate let cellId = "cellId"
    var LocateTitle = ""
    var lat = 1.0
    var lon = 1.0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent //상태표시줄 색상 흰색
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentinfo.removeAll()
        forecastinfo.removeAll()
        lat = UserDefaults.standard.double(forKey: "lat")
        lon = UserDefaults.standard.double(forKey: "lon")
        LocateTitle = UserDefaults.standard.string(forKey: "Name")!

        let url5day = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&APPID=2ac1bbe21fb06a301149057f64c0a926"

       Alamofire.request(url5day, method: .post, encoding: URLEncoding.methodDependent, headers: [:]).responseString { (response) in
            let responseData = response.result.value!.data(using: .utf8)
            do {
                let data = try JSONDecoder().decode(forecast.self, from: responseData!)
                forecastinfo.append(data)
                let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(self.lat)&lon=\(self.lon)&APPID=2ac1bbe21fb06a301149057f64c0a926"

                Alamofire.request(url, method: .post, encoding: URLEncoding.methodDependent, headers: [:]).responseString { (response) in
                    let resData = response.result.value!.data(using: .utf8)
                    do {
                        let data = try JSONDecoder().decode(current.self, from: resData!)
                        currentinfo.append(data)

                        let StretchyTable = StretchyTableController()
                        self.addChild(StretchyTable)

                        //윗 부분 여백을 없애기 위한 좌표 지정
                        StretchyTable.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                        self.view.addSubview(StretchyTable.tableView)

                        //collectionView 셀 속성 지정 및 간격 설정
                        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                        layout.sectionInset = .init(top: 5*self.view.frame.height/812, left: 10, bottom: 5*self.view.frame.height/812, right: 10)
                        layout.itemSize = CGSize(width: 65*self.view.frame.width/375.0, height: 110*self.view.frame.height/812.0)
                        layout.scrollDirection = .horizontal

                        //collectionView 변수 할당 및 설정
                        let collection: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 360*self.view.frame.height/812.0, width: self.view.frame.width, height: 120*self.view.frame.height/812.0), collectionViewLayout: layout)
                        let cellNibs = UINib.init(nibName: "CollectionCell", bundle: nil)
                        collection.register(cellNibs, forCellWithReuseIdentifier: "CollectionCell")
                        collection.delegate = self
                        collection.dataSource = self
                        collection.showsHorizontalScrollIndicator = false
                        collection.backgroundColor = UIColor.init(netHex: 0x403631)
                        self.view.addSubview(collection)

                        //UIView 변수 할당 및 설정
                        let testUIView = UIView()
                        testUIView.backgroundColor = UIColor.init(netHex: 0x403631)
                        testUIView.contentMode = .scaleToFill
                        testUIView.clipsToBounds = true
                        testUIView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 359*self.view.frame.height/812.0)

                        //UILabel 코드로 설정
                        //메인 타이틀(위치)
                        let TextMain = UILabel(frame: CGRect(x: 0, y: 100*self.view.frame.height/812.0, width: self.view.frame.width, height: 50*self.view.frame.height/812.0))
                        TextMain.text = self.LocateTitle
                        TextMain.textColor = .white
                        TextMain.shadowColor = .gray
                        TextMain.font = .systemFont(ofSize: 30*self.view.frame.height/812.0, weight: .semibold)

                        let mainDescription = UILabel(frame: CGRect(x: 0, y: 140*self.view.frame.height/812.0, width: self.view.frame.width, height: 30*self.view.frame.height/812.0))
                        if data.weather[0].main == "Thunderstorm"{
                            mainDescription.text = "뇌우"
                            요약 = "뇌우"
                        } else if data.weather[0].main == "Drizzle"{
                            mainDescription.text = "이슬비"
                            요약 = "이슬비"
                        } else if data.weather[0].main == "Rain"{
                            mainDescription.text = "비"
                            요약 = "비"
                        } else if data.weather[0].main == "Snow"{
                            mainDescription.text = "눈"
                            요약 = "눈"
                        } else if data.weather[0].main == "Clear"{
                            mainDescription.text = "대체로 맑음"
                            요약 = "대체로 맑음"
                        } else if data.weather[0].main == "Clouds"{
                            mainDescription.text = "구름"
                            요약 = "구름"
                        } else if data.weather[0].main == "Smoke"{
                            mainDescription.text = "연기"
                            요약 = "연기"
                        } else if data.weather[0].main == "Haze" || data.weather[0].main == "fog" || data.weather[0].main == "Mist"{
                            mainDescription.text = "안개"
                            요약 = "안개"
                        } else if data.weather[0].main == "Dust" || data.weather[0].main == "Send"{
                            mainDescription.text = "미세먼지 많음"
                            요약 = "미세먼지 많음"
                        } else if data.weather[0].main == "Ash"{
                            mainDescription.text = "화산재"
                            요약 = "화산재"
                        } else if data.weather[0].main == "Squall"{
                            mainDescription.text = "돌풍"
                            요약 = "돌풍"
                        } else if data.weather[0].main == "Tornado"{
                            mainDescription.text = "폭풍"
                            요약 = "폭풍"
                        }
                        mainDescription.textColor = .white
                        mainDescription.shadowColor = .gray
                        mainDescription.font = .systemFont(ofSize: 15, weight: .medium)

                        let tempo = UILabel(frame: CGRect(x: 0, y: 170*self.view.frame.height/812, width: self.view.frame.width, height: 100*self.view.frame.height/812))
                        tempo.text = "\(Int(ceil(data.main.temp-273.15)))"+"º"
                        tempo.textColor = .white
                        tempo.shadowColor = .gray
                        tempo.font = .systemFont(ofSize: 90*self.view.frame.height/812.0, weight: .thin)

                        let cal = Calendar(identifier: .gregorian)
                        let now = Date()
                        let comps = cal.dateComponents([.weekday], from: now)

                        let dayLabel = UILabel(frame: CGRect(x: 20*self.view.frame.width/375.0, y: 315*self.view.frame.height/812.0, width: 55*self.view.frame.width/375.0, height: 30*self.view.frame.height/812.0))

                        if comps.weekday! == 1 {
                            dayLabel.text = "일요일"
                        } else if comps.weekday! == 2 {
                            dayLabel.text = "월요일"
                        } else if comps.weekday! == 3 {
                            dayLabel.text = "화요일"
                        } else if comps.weekday! == 4 {
                            dayLabel.text = "수요일"
                        } else if comps.weekday! == 5 {
                            dayLabel.text = "목요일"
                        } else if comps.weekday! == 6 {
                            dayLabel.text = "금요일"
                        } else if comps.weekday! == 7 {
                            dayLabel.text = "토요일"
                        }

                        dayLabel.textColor = .white
                        dayLabel.shadowColor = .gray
                        dayLabel.font = .systemFont(ofSize: 20*self.view.frame.height/812.0, weight: .medium)

                        let todayLabel = UILabel(frame: CGRect(x: 80*self.view.frame.width/375.0, y: 316*self.view.frame.height/812.0, width: 55*self.view.frame.width/375.0, height: 30*self.view.frame.height/812.0))
                        todayLabel.text = "오늘"
                        todayLabel.textColor = .white
                        todayLabel.shadowColor = .gray
                        todayLabel.font = .systemFont(ofSize: 15*self.view.frame.height/812.0, weight: .medium)

                        let minTempo = UILabel(frame: CGRect(x: 325*self.view.frame.width/375.0, y: 315*self.view.frame.height/812.0, width: 55*self.view.frame.width/375.0, height: 30*self.view.frame.height/812.0))
                        minTempo.text = "\(Int(ceil(data.main.temp_min-273.15)))"
                        minTempo.textColor = .lightText
                        minTempo.font = .systemFont(ofSize: 20*self.view.frame.height/812.0, weight: .medium)

                        let maxTempo = UILabel(frame: CGRect(x: 275*self.view.frame.width/375.0, y: 315*self.view.frame.height/812.0, width: 55*self.view.frame.width/375.0, height: 30*self.view.frame.height/812.0))
                        maxTempo.text = "\(Int(ceil(data.main.temp_max-273.15)))"
                        maxTempo.textColor = .white
                        maxTempo.font = .systemFont(ofSize: 20*self.view.frame.height/812.0, weight: .medium)

                        testUIView.addSubview(TextMain)
                        testUIView.addSubview(mainDescription)
                        testUIView.addSubview(tempo)
                        testUIView.addSubview(dayLabel)
                        testUIView.addSubview(todayLabel)
                        testUIView.addSubview(minTempo)
                        testUIView.addSubview(maxTempo)

                        //택스트 중앙 배치
                        TextMain.textAlignment = .center
                        mainDescription.textAlignment = .center
                        tempo.textAlignment = .center

                        self.view.addSubview(testUIView)

                        //toolbar
                        let toolbar = UIToolbar()

                        if self.view.frame.height>=812 && self.view.frame.height<=896 {
                            toolbar.frame = CGRect(x: 0, y: 733*self.view.frame.height/812.0, width: self.view.frame.width, height: 60*self.view.frame.height/812.0)
                        } else if self.view.frame.height>896 {
                            toolbar.frame = CGRect(x: 0, y: 760*self.view.frame.height/812.0, width: self.view.frame.width, height: 45*self.view.frame.height/812.0)
                        } else {
                            toolbar.frame = CGRect(x: 0, y: 768*self.view.frame.height/812.0, width: self.view.frame.width, height: 45*self.view.frame.height/812.0)
                        }

                        let transButton = UIBarButtonItem(title: "재설정", style: .plain, target: self, action: #selector(self.reselectLocation))
                        transButton.accessibilityFrame = CGRect(x: 0, y: 5, width: 30, height: 30)
                        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                        toolbar.setItems([spaceButton, transButton], animated: false)
                        toolbar.barTintColor = testUIView.backgroundColor
                        toolbar.tintColor = .white
                        let topBorder = CALayer()
                        topBorder.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.5)
                        topBorder.backgroundColor = UIColor.lightText.cgColor
                        toolbar.layer.addSublayer(topBorder)
                        self.view.addSubview(toolbar)

                        //top 경계선
                        let separatorLine = UIView()
                        separatorLine.frame = CGRect(x: 0, y: 359.5*self.view.frame.height/812.0, width: self.view.frame.width, height: 0.5)
                        separatorLine.backgroundColor = .lightText
                        self.view.addSubview(separatorLine)

                        //bottom 경계선
                        let separatorLineB = UIView()
                        separatorLineB.frame = CGRect(x: 0, y: 479.5*self.view.frame.height/812.0, width: self.view.frame.width, height: 0.5)
                        separatorLineB.backgroundColor = .lightText
                        self.view.addSubview(separatorLineB)

                        //tableViewController에 추가 - ScrollView 연동
                        StretchyTable.StUIView = testUIView
                        StretchyTable.StcollectionView = collection
                        StretchyTable.separator = separatorLine
                        StretchyTable.separatorB = separatorLineB
                    } catch {
                        print(error)
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    //화면전환,검색한 위치 정보 저장
    @objc func reselectLocation() {
        UserDefaults.standard.removeObject(forKey: "Name")
        UserDefaults.standard.removeObject(forKey: "lat")
        UserDefaults.standard.removeObject(forKey: "lon")
        performSegue(withIdentifier: "Search", sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH"
        dateFormatterTime.timeZone = NSTimeZone(name: "KST") as TimeZone?
        let forecastDtAm = dateFormatterTime.string(from: NSDate(timeIntervalSince1970: Double(forecastinfo[0].list[indexPath.row].dt)) as Date)
        if (Int(forecastDtAm) ?? nil)! > 12 {
            let forecastDtPm = dateFormatterTime.string(from: NSDate(timeIntervalSince1970: Double(forecastinfo[0].list[indexPath.row].dt)-3600*12) as Date)
            cell.timeLabel.text = "오후 \(forecastDtPm)시"
        } else {
            cell.timeLabel.text = "오전 \(forecastDtAm)시"
        }

        cell.temLabel.text = "\(Int(ceil(forecastinfo[0].list[indexPath.row].main.temp-273.15)))"+"º"

    cell.weatherImage.downloadImageFrom("http://openweathermap.org/img/wn/\(forecastinfo[0].list[indexPath.row].weather[0].icon)@2x.png", contentMode: .scaleAspectFit)

        return cell
    }
}
