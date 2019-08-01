//
//  TableViewController.swift
//  kakao_weather
//
//  Created by 남기범 on 01/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit
import MapKit

class TableViewController: UITableViewController {
    var resultSearchController:UISearchController? = nil
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        //셀에 표시되는 검색결과의 String 값
        cell.textLabel?.text = selectedItem.title
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //선택 동작 - 위도 경도 추출
        let selectedItem = matchingItems[indexPath.row].placemark
        print(selectedItem.coordinate.latitude)
        print(selectedItem.coordinate.longitude)
        
    }

}
extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()//검색 요청 메소드 지정
        request.naturalLanguageQuery = searchBarText//스트링값 검색창에서 가져오기
        request.region = mapView.region//지도에서 영역 가져오기
        let search = MKLocalSearch(request: request)
        //검색 시작
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems

            self.tableView.reloadData()
        }
    }
    
}
