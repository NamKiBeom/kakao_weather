# kakao_weather
KakaoPay_homework

OpenWeather API를 사용한 날씨 어플리케이션

MapKit을 활용한 위치검색(lat,lon)

collectionView와 TableView를 연동하여 ScrollView에 접목시켜 Stretch 효과

AlamoFire를 사용하여 HTTP 통신

Codable을 이용하여 JSON 파싱

# 사용가능한 Device
아이폰 모두(아이패드 x)

# Screen Shot

<img src=./image/Search.jpeg width="30%"><img src=./image/SearchTable.jpeg width="30%"><img src=./image/Result.jpeg width="30%">




# 실행순서

왼쪽부터 1,2,3으로 스크린샷 번호를 부여한다.

1. 처음 어플리케이션을 실행하면 1번화면이 실행된다. 

2. 검색을 위해 검색창을 터치하면 2번화면이 로드되고 원하는 위치를 검색한다. 

3. 검색한 위치를 선택하면 그 위치에 대한 위도와 경도 값으로 날씨정보를 API에 요청한다. 

4. 3번화면이 실행된다.

5. 어플리케이션을 종료할 경우 내가 전에 검색했던 위치가 저장되어 바로 3번화면이 로드된다.




# 참고사항

현재 날씨에 대한 정보는 OpenWeather API에서 Current Weather API를 사용했고, 3시간 간격 및 5일의 날씨는 5 Days / 3 Hours Forecast API를 사용했습니다. 
5일의 날씨에서의 최고,최저기온이 현재날씨의 최고,최저기온과 다를 수 있습니다. 정확한 이유는 잘 모르겠으나 아마 각 상황에 따라 다른 API를 사용하기 때문에 응답받은 데이터에서 차이가 있는 것 같습니다.(수정 완료 - 5일의 날씨 중 현재의 날짜와 동일한 경우, Current Weather API의 정보로 교체)

 5일의 최고,최저기온이 같은 경우가 많습니다. 그 이유는 5 Days / 3 Hours Forecast API에서 그 날에 대한 최고,최저기온을 출력하는 것이 아닌 특정한 날 및 특정한 3시간의 최고,최저기온을 출력하기 때문입니다.(수정 완료)

현재 아이폰에서 기본적으로 제공하고 있는 날씨 어플리케이션과 매우 유사한 디자인입니다. 날씨 어플리케이션을 한 번도 개발해본 경험이 없어서 기본적으로 제공하고 있는 날씨 어플리케이션과 유사하게 만들려고 노력했습니다. 코드를 확인하시면 아시겠지만, 혹시나 하는 마음에 말씀드리자면 다른 사람이 만들어 놓은 샘플은 사용하지 않았습니다. 
