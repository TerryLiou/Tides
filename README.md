# Tides / 潮戲

Tides 是一個查詢台灣潮汐的 App ，之所以以 “戲” 命名是希望這款 App 相較於一般的資料查詢工具多了互動性。

## Feature

* 潮汐資訊
  * 以圖表顯示一日乾潮滿潮之時間與潮高
  * 第一次進入 App 將呈現預設地點宜蘭縣蘇澳鎮之資訊
  * 點選日曆可以選擇未來一週的潮汐資訊

![App Launching](https://github.com/TerryLiou/Tides/blob/master/screenShot/charts.gif?raw=true)

* 潮汐查詢
  * 列表搜尋可以透過輸入地名來過濾列表中的資訊，在點擊地區後將會轉跳回潮汐資訊頁面，顯示所選擇日期的該地點潮汐資訊
  * 地圖方式主要呈現台灣各個漁港、碼頭、港阜，點擊標示會彈出資訊視窗，顯示改地點與使用者位置的距離，點擊 “ i ” 按鈕將轉跳回潮汐資訊

![TableView](https://github.com/TerryLiou/Tides/blob/master/screenShot/tableView.png?raw=true)
![MapView](https://github.com/TerryLiou/Tides/blob/master/screenShot/map.png?raw=true)

* 天氣資訊
  * 通常想知道潮汐的使用者也會關心地點的天氣資訊，所以 Tides 也提供了氣候相關的資訊
  * 左上角顯示的是降雨機率，右上角顯示的是濕度
  * 左下角顯示的是風向，以及風級風速的描述
  * Collection View 顯示未來 24 小時的天氣，點選 Cell 更新頁面資訊

![Weather](https://github.com/TerryLiou/Tides/blob/master/screenShot/weather.png?raw=true)

* 月零資訊
  * 關心潮汐的族群會想知道的另一個資訊是月亮的圓缺，關係到當天晚上的亮度
  * 可以選擇未來一個月的月齡資訊
  * 點選 Cell 月球模型將轉動到當晚月球的盈缺

![Moon](https://github.com/TerryLiou/Tides/blob/master/screenShot/moon.gif?raw=true)

## Libraries

* Alamofire
* Charts
* Fabric Crashlytics
* Firebase
* Firebase Analytics
* JTAppleCalendar
* SwiftLint

## Requirement

* iOS 10.2+
* Xcode 8.3+
* pod install

## Contacts

* Wei-Shiun Liou 劉洧熏
* [b9503081@gmail.com](b9503081@gmail.com)
