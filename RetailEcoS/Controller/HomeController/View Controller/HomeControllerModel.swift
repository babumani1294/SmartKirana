//
//  HomeControllerModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-10.
//

import Foundation


class HomeControllerModel: Codable {
    var session : HomeSession?
    var status : HomeStatus?
}

class HomeSession : Codable{
    var SessionMessage : String?
    var SessionResult : Int?
}

class HomeStatus : Codable{
    var Message : String?
    var Result : Int?
    var Menu : [Menu]
    var Menu_Head : String?
}

class Menu : Codable{
    var val : String?
    var Id : String?
    var status : String?
}


class CountryNameModel: Codable {
    var session : CountrySession?
    var status : CountryStatus?
}

class CountrySession : Codable{
    var SessionMessage : String?
    var SessionResult : Int?
}

class CountryStatus : Codable{
    var COUNTRY : [CountryDetails?]
}

class CountryDetails: Codable {
    var Currency_symbol : String?
    var Country_flag : String?
    var Country_Code : String?
    var Longitude : Double?
    var Postal_Code_Format : String?
    var Latitude : Double?
    var Country_Name : String?
    var Currency_code : String?
}

//{"session":{"SessionMessage":"Login Valid","SessionResult":1},"status":{"Message":"Success","Menu_Head_Desc":"What is your buying type today? Select the Menu","Menu":[{"val":"Postal Code","Id":"1","status":"0"},{"val":"Shop from Home","Id":"2","status":"0"},{"val":"Grocery","Id":"3","status":"0"},{"val":"Home Delivery","Id":"4","status":"0"},{"val":"Delivery Address","Id":"5","status":"0"},{"val":"My Shop","Id":"6","status":"0"},{"val":"Delivery Time","Id":"7","status":"0"}],"Menu_Head":"Select Menu","Result":1}}


class DeviceID: Codable{
    
    var Device_id: String?
    
    init(getDeviceId: String) {
        self.Device_id = getDeviceId
    }
}
