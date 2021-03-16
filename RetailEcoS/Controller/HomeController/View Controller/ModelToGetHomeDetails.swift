//
//  HomeControllerModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-10.
//

import Foundation



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






class ModelToGetCountyAddress: Codable {
    var results : [CountryAddressResult?]
    var status : String?
}


class CountryAddressResult: Codable {
    var address_components  : [CountryAddressComponent?]
    var formatted_address : String?
    var geometry  : CountryGeometry?
    var place_id : String?
    var types : [String]
}

class CountryAddressComponent: Codable {
    var long_name  : String?
    var short_name : String?
    var types  : [String]
}

class CountryGeometry: Codable {
    var bounds : CountryViewPort?
    var location  : CountryLocation?
    var location_type : String?
    var viewport : CountryViewPort?
    
}

class CountryLocation: Codable {
    var lat  : Double?
    var lng  : Double?
}

class CountryViewPort: Codable {
    var northeast  : CountryLocation?
    var southwest  : CountryLocation?
}





//{
//   "results" : [
//      {
//         "address_components" : [
//            {
//               "long_name" : "600078",
//               "short_name" : "600078",
//               "types" : [ "postal_code" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Tamil Nadu",
//               "short_name" : "TN",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "India",
//               "short_name" : "IN",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Chennai, Tamil Nadu 600078, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.0474429,
//                  "lng" : 80.2116812
//               },
//               "southwest" : {
//                  "lat" : 13.0308542,
//                  "lng" : 80.1881368
//               }
//            },
//            "location" : {
//               "lat" : 13.0410254,
//               "lng" : 80.2000596
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.0474429,
//                  "lng" : 80.2116812
//               },
//               "southwest" : {
//                  "lat" : 13.0308542,
//                  "lng" : 80.1881368
//               }
//            }
//         },
//         "place_id" : "ChIJh_WeI3FdUjoRtYkpIEDkq3U",
//         "types" : [ "postal_code" ]
//      }
//   ],
//   "status" : "OK"
//}




class ModelToGetCountyTimeZone: Codable {
    var dstOffset: Double?
    var rawOffset: Double?
    var status : String?
    var timeZoneId : String?
    var timeZoneName : String?
}





//{
//   "dstOffset" : 0,
//   "rawOffset" : -18000,
//   "status" : "OK",
//   "timeZoneId" : "America/New_York",
//   "timeZoneName" : "Eastern Standard Time"
//}



class DeviceID: Codable{
    
    var Device_id: String?
    
    init(getDeviceId: String) {
        self.Device_id = getDeviceId
    }
}


///MODEL TO REQUEST/ GET /UPDATE HOME DETAILS.

//REQUEST HOME DETAILS

class ModelToRequestHomeDetails: Codable{
    
    var Device_id: String?
    var Postal_Code: String?
    
    init(getDeviceId: String,getPostalCode: String) {
        self.Device_id = getDeviceId
        self.Postal_Code = getPostalCode
    }
}


//GET HOME DETAILS

class ModelToGetHomeDetails: Codable {
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
    var Menu : [Menu]?
}

class Menu : Codable{
    var Menu_Id : Int?
    var Sub_Menu : [SubMenu]?
    var Menu_Enable : Int?
    var Menu_Action : String?
    var Is_Arrow : String?
}

class SubMenu: Codable {
    var Imagepath : String?
    var Innerid : Int?
    var Value : String?
    var Name : String?
    var status : Int?
}

///MARK: RESPONSE

//{"session":{"SessionMessage":"Login Valid","SessionResult":1},"status":{"Message":"Success","Menu":[{"Menu_Id":1,"Sub_Menu":[{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/1_postalcode.png","Innerid":1,"Value":" ","Name":"Postal Code","status":1}],"Is_Arrow":"N","Menu_Enable":1,"Menu_Action":"https://www.smartkirana.ca/retailecos/Logo/arrow1_front4.png"},{"Menu_Id":2,"Sub_Menu":[{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/2_shopfromhome.png","Innerid":1,"Value":" ","Name":"Shop from Home","status":1},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/shopatstoreNew.png","Innerid":2,"Value":" ","Name":"Shop @ Store","status":0}],"Is_Arrow":"Y","Menu_Enable":1,"Menu_Action":"https://www.smartkirana.ca/retailecos/Logo/refresh.png"},{"Menu_Id":3,"Sub_Menu":[{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Apparel.png","Innerid":1,"Value":" ","Name":"Apparel","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Appliances.png","Innerid":2,"Value":" ","Name":"Appliances","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/BeautyCare.png","Innerid":3,"Value":" ","Name":"Beauty Care","status":1},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Electrical.png","Innerid":4,"Value":" ","Name":"Electrical","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Eyewear.png","Innerid":5,"Value":" ","Name":"Eyewear","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Fashion.png","Innerid":6,"Value":" ","Name":"Fashion","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Footwear.png","Innerid":7,"Value":" ","Name":"Footwear","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Furniture.png","Innerid":8,"Value":" ","Name":"Furniture","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Grocery.png","Innerid":9,"Value":" ","Name":"Grocery","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Jewellery.png","Innerid":10,"Value":" ","Name":"Jewellery","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Luggage.png","Innerid":11,"Value":" ","Name":"Luggage","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/Stationary.png","Innerid":12,"Value":" ","Name":"Stationary","status":0}],"Is_Arrow":"N","Menu_Enable":1,"Menu_Action":"https://www.smartkirana.ca/retailecos/Logo/arrow1_front4.png"},{"Menu_Id":4,"Sub_Menu":[{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/4_homedelivery.png","Innerid":1,"Value":" ","Name":"Home Delivery","status":1},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/curb_new.png","Innerid":2,"Value":" ","Name":"Kerb Side Pickup","status":0}],"Is_Arrow":"Y","Menu_Enable":1,"Menu_Action":"https://www.smartkirana.ca/retailecos/Logo/refresh.png"},{"Menu_Id":5,"Sub_Menu":[{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/5_deliveryaddress.png","Innerid":1,"Value":" ","Name":"Home Address","status":1},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/5_deliveryaddress.png","Innerid":2,"Value":" ","Name":"Office Address","status":0},{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/5_deliveryaddress.png","Innerid":3,"Value":" ","Name":"Other - Select","status":0}],"Is_Arrow":"N","Menu_Enable":1,"Menu_Action":"https://www.smartkirana.ca/retailecos/Logo/arrow1_front4.png"},{"Menu_Id":6,"Sub_Menu":[{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/6_prefferedStore.png","Innerid":1,"Value":" ","Name":"Preferred Store","status":1}],"Is_Arrow":"N","Menu_Enable":1,"Menu_Action":"https://www.smartkirana.ca/retailecos/Logo/arrow1_front4.png"},{"Menu_Id":7,"Sub_Menu":[{"Imagepath":"https://www.smartkirana.ca/retailecos/Logo/7_preferred_del_time.png","Innerid":1,"Value":" ","Name":"Preferred Del.Time","status":1}],"Is_Arrow":"N","Menu_Enable":1,"Menu_Action":"https://www.smartkirana.ca/retailecos/Logo/arrow1_front4.png"}],"Result":1}}



//----------------------

/// MODEL TO FETCH RETAIL VERTICAL BASED ON TYPE

class ModelToRequestRetailDetailsOfType: Codable{
    
    var Device_id: String?
    var VType: Int?
    
    init(getDeviceId: String,getType: Int) {
        self.Device_id = getDeviceId
        self.VType = getType
    }
}


class ModelToGetRetailForType: Codable {
    var session : VerticalSession?
    var status : VerticalStatus?
}

class VerticalSession : Codable{
    var SessionMessage : String?
    var SessionResult : Int?
}

class VerticalStatus : Codable{
    var Vertical : [Vertical]
    var Message: String?
    var Result: Int?
}

class Vertical : Codable{
    var val : String?
    var Id : Int?
    var url_unselected: String?
    var url_selected: String?
    var status: Int?
}


//var fetchVerticalDetails  =  [(UIImage?,UIImage?,UIImage?, Bool,String,Int,Int)]()

//{
//"session":{
//"SessionMessage":"Login Valid","SessionResult":1},
//"status":{
//"Vertical":[
//{"val":"Apparel","Id":1,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Apparel.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Apparel_S.png","status":0},
//{"val":"Appliances","Id":2,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Appliances.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Appliances_S.png","status":0},
//{"val":"Beauty Care","Id":3,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/BeautyCare.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/BeautyCare_S.png","status":0},
//{"val":"Electrical","Id":4,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Electrical.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Electrical_S.png","status":0},
//{"val":"Eyewear","Id":5,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Eyewear.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Eyewear_S.png","status":0},
//{"val":"Fashion","Id":6,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Fashion.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Fashion_S.png","status":0},
//{"val":"Footwear","Id":7,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Footwear.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Footwear_S.png","status":0},
//{"val":"Furniture","Id":8,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Furniture.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Furniture_S.png","status":0},
//{"val":"Grocery","Id":9,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Grocery.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Grocery_S.png","status":0},
//{"val":"Jewellery","Id":10,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Jewellery.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Jewellery_S.png","status":0},
//{"val":"Luggage","Id":11,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Luggage.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Luggage_S.png","status":0},
//{"val":"Stationary","Id":12,"url_unselected":"https://www.smartkirana.ca/retailecos/Logo/Stationary.png","url_selected":"https://www.smartkirana.ca/retailecos/Logo/Stationary_S.png","status":0}
//],
//"Message":"Success",
//"Result":1
//}
//}




///MARK: MODEL TO UPDATE HOME DETAILS


class ModelToUpdateHomeDetails: Codable{
    
    var Device_id: String
    var Menu = [getUpdateToHomeDetails]()
    
    init(getDevice: String,getMenu: [getUpdateToHomeDetails]) {
        self.Device_id = getDevice
        self.Menu = getMenu
    }
}

class getUpdateToHomeDetails : Codable{
    var Menu_Id : Int
    var Menu_Enable : Int
    var Value : String
    var Innerid : Int
    
    init(getMenuId: Int,getMenuEnable: Int,getValue: String,getInnerId: Int) {
        self.Menu_Id = getMenuId
        self.Menu_Enable = getMenuEnable
        self.Value = getValue
        self.Innerid = getInnerId
    }
}


//{
//"Device_id":"XXXX-XXXX-XXXXXXXX",
//"Menu":[ {"Menu_Id":1,"Menu_Enable":1,"Value":"L4E 0A2","Innerid":1},
//{"Menu_Id":2,"Menu_Enable":1,"Value":"","Innerid":1},
//{"Menu_Id":3,"Menu_Enable":1,"Value":"","Innerid":2},
//{"Menu_Id":4,"Menu_Enable":1,"Value":"","Innerid":6},
//{"Menu_Id":5,"Menu_Enable":1,"Value":"","Innerid":2},
//{"Menu_Id":6,"Menu_Enable":1,"Value":"","Innerid":1},
//{"Menu_Id":7,"Menu_Enable":1,"Value":"","Innerid":1} ]
//}

class ModelToGetHomeDetailUpdateResponse : Codable{
    var session : HomeDetailResponseSession
    var status : HomeDetailResponseStatus
}

class HomeDetailResponseSession : Codable{
    var SessionMessage : String
    var SessionResult : Int?
}

class HomeDetailResponseStatus : Codable{
    var Message : String?
    var Result : Int?
}

//{
//"session":{"SessionMessage":"Login Valid","SessionResult":1},
//"status":{"Message":"Menu Updated Successfully","Result":1}
//}


//----------------------
class ModelToGiveDevicePostal: Codable{
    
    var Device_Id: String?
    var Postal_Code: String?
    
    init(getDeviceId: String,getPostalCode: String) {
        self.Device_Id = getDeviceId
        self.Postal_Code = getPostalCode
    }
}


///MARK: MODEL TO FETCH ADDRESS DETAILS:


//{
//"session":{
//"SessionMessage":"Login Valid","SessionResult":1},
//"status":{
//"Message":"Success",
//"Deviceaddress":[
//{"SALUTATIONS":"Mr",
//"MOBILE_NUMBER":"1234567",
//"ADDRESS_TYPE":"W",
//"POSTAL_CODE":"L4E 0A8",
//"STATE":"ONTARIO",
//"LAST_NAME":"SUNDAR",
//"EMAIL":"test@paceautomation.com",
//"AREA_CODE":"984",
//"FIRST_NAME":"SURYS",
//"LOCALITY":"Hill",
//"COUNTRY":"INDIA",
//"CITY":"RICHMAND HILL",
//"DEVICE_ID":"XXXX-XXXX-XXXXXXXX",
//"BUILDING_TYPE":"A",
//"ADDRESS_1":"10,HILL STREET",
//"COUNTRY_CODE":"91",
//"ADDRESS_2":"NEAR ZOO"}
//],
//"Result":1}
//}

//{"session":{"SessionMessage":"Login Valid","SessionResult":1},"status":{"Message":"Error Found","Result":0}}


class ModelToFetchAddressDetails: Codable {
    var session : AddressSession
    var status : AddressStatus
}

class AddressSession : Codable{
    var SessionMessage : String
    var SessionResult : Int?
}

class AddressStatus : Codable{
    var Message : String?
    var Deviceaddress: [AddressDetails]?
    var Result : Int?
}

class AddressDetails : Codable{
    var DEVICE_ID: String?
    var FIRST_NAME: String?
    var LAST_NAME: String?
    var ADDRESS_TYPE: String?
    var COUNTRY_CODE: String?
    var AREA_CODE: String?
    var MOBILE_NUMBER: String?
    var ADDRESS_1: String?
    var ADDRESS_2: String?
    var LOCALITY: String?
    var POSTAL_CODE: String?
    var STATE: String?
    var CITY: String?
}

class ModelToUpdateAddress: Codable{
    
    var DEVICE_ID: String?
    var FIRST_NAME: String?
    var LAST_NAME: String?
    var ADDRESS_TYPE: String?
    var COUNTRY_CODE: String?
    var AREA_CODE: String?
    var MOBILE_NUMBER: String?
    var ADDRESS_1: String?
    var ADDRESS_2: String?
    var LOCALITY: String?
    var POSTAL_CODE: String?
    var STATE: String?
    var CITY: String?
    
    
    init(getDeviceId: String,getFirsName: String,getLastName: String,getAddress1: String,getAddress2: String,getLocality: String,getCity: String,getState: String,getPostalCode: String,getAddressType: String,getAreaCode: String,getCountryCode: String,getMobileNumber: String) {
        self.DEVICE_ID = getDeviceId
        self.FIRST_NAME = getFirsName
        self.LAST_NAME = getLastName
        self.ADDRESS_1 = getAddress1
        self.ADDRESS_2 = getAddress2
        self.LOCALITY = getLocality
        self.CITY = getCity
        self.STATE = getState
        self.POSTAL_CODE = getPostalCode
        self.ADDRESS_TYPE = getAddressType
        self.AREA_CODE = getAreaCode
        self.COUNTRY_CODE = getCountryCode
        self.MOBILE_NUMBER = getMobileNumber
    }
}

class ModelToGetUpdateResponse : Codable{
    var session : UpdateResponseSession
    var status : UpdateResponseStatus
}

class UpdateResponseSession : Codable{
    var SessionMessage : String
    var SessionResult : Int?
}

class UpdateResponseStatus : Codable{
    var Message : String?
    var Result : Int?
}





