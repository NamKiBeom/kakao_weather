//
//  TableViewController.swift
//  kakao_weather
//
//  Created by 남기범 on 01/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit
import MapKit
import Alamofire


class TableViewController: UITableViewController {
    var resultSearchController:UISearchController? = nil
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var latselect = 1.0
    var lonselect = 1.0
    var subtitle = ""

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
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = selectedItem.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //선택 동작 - 위도 경도 추출
        let selectedItem = matchingItems[indexPath.row].placemark
        latselect = selectedItem.coordinate.latitude
        lonselect = selectedItem.coordinate.longitude
        subtitle = selectedItem.name!
        performSegue(withIdentifier: "back", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rvc = segue.destination as? StretchyController{
            rvc.LocateTitle = subtitle
            rvc.lat = self.latselect
            rvc.lon = self.lonselect
        }
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // state
            selectedItem.administrativeArea ?? "",
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace
        )
        return addressLine
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
