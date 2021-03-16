//
//  RetailSelectionModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-03.
//

import Foundation


class ModelUpdateRetailDetails: Codable{
    
    var Device_id: String
    var Vertical = [getId]()
    
    init(getDevice: String,getVertical: Int) {
        self.Device_id = getDevice
        self.Vertical.append(getId(getId: getVertical))
    }
}

class getId : Codable{
    var Id : Int
    init(getId: Int) {
        self.Id = getId
    }
}



//{
//"Device_id":"XXXX-XXXX-XXXXXXXX",
//"Vertical":[{"Id":4}]
//}


class ModelToGetUpdateRetailResponse: Codable {
    var session : UpdateRetailResponseSession
    var status : UpdateRetailResponseStatus
    
}

class UpdateRetailResponseSession : Codable{
    var SessionMessage : String
    var SessionResult : Int
}

class UpdateRetailResponseStatus : Codable{
    var Message : String
    var Result : Int
}


//{
//"session":{"SessionMessage":"Login Valid","SessionResult":1},
//"status":{"Message":"Vertical Updated Successfully","Result":1}
//}


class ModelToGetRetailDetails: Codable {
    var session : RetailSession
    var status : RetailStatus
}

class RetailSession : Codable{
    var SessionMessage : String
    var SessionResult : Int
}

class RetailStatus : Codable{
    var Vertical_Head : String?
    var Vertical_Head_Desc : String?
    var Message : String?
    var Error : String?
    var PERMISSION: [RetailVerticals]?
    var Result : Int?
}


class RetailVerticals : Codable{
    var val : String?
    var Id : Int?
    var url_unselected : String?
    var url_selected : String?
    var status : String?
}

//{"session":{"SessionMessage":"Login Valid","SessionResult":1},"status":{"PERMISSION":[{"val":"Apparel","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Apparel.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Apparel_S.png","Id":1,"status":"0"},{"val":"Appliances","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Appliances.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Appliances_S.png","Id":2,"status":"0"},{"val":"Beauty Care","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Beauty Care.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Beauty Care_S.png","Id":3,"status":"0"},{"val":"Electrical","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Electrical.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Electrical_S.png","Id":4,"status":"0"},{"val":"Eyewear","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Eyewear.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Eyewear_S.png","Id":5,"status":"0"},{"val":"Fashion","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Fashion.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Fashion_S.png","Id":6,"status":"0"},{"val":"Footwear","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Footwear.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Footwear_S.png","Id":7,"status":"0"},{"val":"Furniture","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Furniture.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Furniture_S.png","Id":8,"status":"0"},{"val":"Grocery","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Grocery.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Grocery_S.png","Id":9,"status":"0"},{"val":"Jewellery","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Jewellery.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Jewellery_S.png","Id":10,"status":"0"},{"val":"Luggage","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Luggage.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Luggage_S.png","Id":11,"status":"0"},{"val":"Stationary","url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Stationary.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Stationary_S.png","Id":12,"status":"0"}],"Message":"Success","Error":"You Should Select Grocery Only","Vertical_Head":"Select Retail Vertical","Vertical_Head_Desc":"What is your buying pleasure today?Select the Retail Vertical","Result":1}}
