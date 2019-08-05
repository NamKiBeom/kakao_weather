//
//  StretchyTableController.swift
//  kakao_weather
//
//  Created by 남기범 on 01/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit
import Alamofire

class StretchyTableController: UITableViewController{
    var StcollectionView : UICollectionView? = nil
    var StUIView : UIView? = nil
    var separator : UIView? = nil
    var separatorB : UIView? = nil
    var firstdt = forecastinfo[0].list[0].dt
    var dayArray = ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"]
    
    
    //2ac1bbe21fb06a301149057f64c0a926
    override func viewDidLoad() {
        super.viewDidLoad()
        var ks:Int = 1
        if view.frame.height >= 768{
            ks = 430
        }
        else
        {
            ks = 480
        }
        tableView.contentInset = UIEdgeInsets(top: 440*view.frame.height/768.0, left: 0, bottom: 0, right: 0)
        tableView.insetsContentViewsToSafeArea == false
        tableView.separatorStyle = .none
        
        //커스텀 테이블뷰를 구현하기 위한 수단
        //새로운 클래스를 만들어서 연결함
        let cellNib = UINib.init(nibName: "StretchyViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell1")
        let cellNib1 = UINib.init(nibName: "DescriptionCell", bundle: nil)
        tableView.register(cellNib1, forCellReuseIdentifier: "DescriptionCell")
        let cellNib2 = UINib.init(nibName: "EtcViewCell", bundle: nil)
        tableView.register(cellNib2, forCellReuseIdentifier: "EtcViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 5
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! StretchyViewCell
            
            var i = 0
            while(true){
                
                if firstdt == forecastinfo[0].list[i].dt{                cell.weather?.downloadImageFrom("http://openweathermap.org/img/wn/\(forecastinfo[0].list[i].weather[0].icon)@2x.png", contentMode: .scaleAspectFill)
                    
                    let cal = Calendar(identifier: .gregorian)
                    let now = Date()
                    let comps = cal.dateComponents([.weekday], from: now)
                    
                    if comps.weekday!+indexPath.row <= 7{
                        cell.day.text = dayArray[comps.weekday!+indexPath.row-1]
                    }
                    else{
                        cell.day.text = dayArray[comps.weekday!+indexPath.row-8]
                    }
                    
                    cell.max.text = String(Int(ceil(forecastinfo[0].list[i].main.temp_max-273.15)))
                    cell.min.text = String(Int(ceil(forecastinfo[0].list[i].main.temp_min-273.15)))
                    
                    firstdt = firstdt + 86400
                    break
                }
                
                i = i+1
            }
            return cell
        }
        else if indexPath.row == 5
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
            cell.DescriptionText.text = "날씨요약: 현재 날씨는 "+요약+", 최고기온은 \(Int(ceil(currentinfo[0].main.temp_max-273.15)))º, 최저기온은 \(Int(ceil(currentinfo[0].main.temp_min-273.15)))º입니다."
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EtcViewCell") as! EtcViewCell
            cell.smallLabel1.shadowColor = .gray
            cell.smallLabel2.shadowColor = .gray
            cell.bigLabel1.shadowColor = .gray
            cell.bigLabel2.shadowColor = .gray
            
            cell.bigLabel1.adjustsFontSizeToFitWidth = true
            if indexPath.row == 6
            {
                cell.smallLabel1.text = "바람속도"
                cell.smallLabel2.text = "구름"
                cell.bigLabel1.text = "\(Int(ceil(currentinfo[0].wind.speed)))m/s"
                cell.bigLabel2.text = "\(currentinfo[0].clouds.all)%"
                return cell
            }
            else if indexPath.row == 7
            {
                cell.smallLabel1.text = "기압"
                cell.smallLabel2.text = "습도"
                cell.bigLabel1.text = "\(currentinfo[0].main.pressure)hPa"
                cell.bigLabel2.text = "\(currentinfo[0].main.humidity)%"
                return cell
            }
            else if indexPath.row == 8{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                dateFormatter.timeZone = NSTimeZone(name:  "KST") as TimeZone?
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "HH"
                dateFormatter1.timeZone = NSTimeZone(name:  "KST") as TimeZone?
                //오후 계산
                
                var sunriseString1 = dateFormatter1.string(from: NSDate(timeIntervalSince1970: Double(currentinfo[0].sys.sunrise)) as Date)
                var sunsetString1 = dateFormatter1.string(from: NSDate(timeIntervalSince1970: Double(currentinfo[0].sys.sunset)) as Date)
                
                cell.smallLabel1.text = "일출"
                cell.smallLabel2.text = "일몰"
                if (Int(sunriseString1) ?? nil)! > 12{
                     var sunriseString = dateFormatter.string(from: NSDate(timeIntervalSince1970: Double(currentinfo[0].sys.sunrise)-3600*12) as Date)
                    cell.bigLabel1.text = "오후 \(sunriseString)"
                }else{
                    var sunriseString = dateFormatter.string(from: NSDate(timeIntervalSince1970: Double(currentinfo[0].sys.sunrise)) as Date)
                    cell.bigLabel1.text = "오전 \(sunriseString)"
                }
                if (Int(sunsetString1) ?? nil)! > 12{
                    var sunsetString = dateFormatter.string(from: NSDate(timeIntervalSince1970: Double(currentinfo[0].sys.sunset)-3600*12) as Date)
                    cell.bigLabel2.text = "오후 \(sunsetString)"
                }else{
                    var sunsetString = dateFormatter.string(from: NSDate(timeIntervalSince1970: Double(currentinfo[0].sys.sunset)) as Date)
                    cell.bigLabel2.text = "오전 \(sunsetString)"
                }
                return cell
            }
            else{
                cell.smallLabel1.isHidden = true
                cell.smallLabel2.isHidden = true
                cell.bigLabel1.isHidden = true
                cell.bigLabel2.isHidden = true
                cell.bottom.isHidden = true
                return cell
            }
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
        scrollView.backgroundColor = UIColor.init(netHex: 0x403631)
        scrollView.showsVerticalScrollIndicator = false
        let y = -scrollView.contentOffset.y//지정한 인셋의 값
        let height = max(270*view.frame.height/768.0, y-(120*view.frame.height/768.0))
        
        //첫번째 헤더-스크롤시 높이 변화, 위치 고정
        StUIView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        separator?.frame = CGRect(x: 0, y: height-0.7, width: view.frame.width, height: 0.7)
        StcollectionView?.frame = CGRect(x: 0, y: height, width: view.frame.width, height: (120*view.frame.height/768.0)-1)
        separatorB?.frame = CGRect(x: 0, y: height+(120*view.frame.height/768.0)-1, width: view.frame.width, height: 0.7)
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
extension UIImageView {
    func downloadImageFrom(_ link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
    
    func downloadAndResizeImageFrom(_ link:String, contentMode: UIView.ContentMode ,newWidth:CGFloat) {
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data {
                    if let tempImage = UIImage(data: data){
                        let scale = newWidth / tempImage.size.width
                        let newHeight = tempImage.size.height * scale
                        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
                        tempImage.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
                        let newImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        self.image = newImage
                    }
                }
            }
        }).resume()
    }
}
