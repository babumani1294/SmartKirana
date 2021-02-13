//
//  MobileRegisterModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-01.
//

import Foundation
import UIKit

class ModelToGiveCountry: Codable{
    
    var Country: String?
    var Curr_Timestamp: String?
    var Device_id: String?
    
    init(getCountry: String, getTimeStamp: String, getDeviceId: String) {
        self.Country = getCountry
        self.Curr_Timestamp = getTimeStamp
        self.Device_id = getDeviceId
    }
}



class ModelToFetchCompanyDetails: Codable {
    var session : Session
    var status : Status
}

class Session : Codable{
    var SessionMessage : String
    var SessionResult : Int
}

class Status : Codable{
    var Country_flag : String?
    var Message : String?
    var splash: [SplashList]?
    var Result : Int?
    
//    init(getCountry: String,Message: String,splash: [SplashList],result: Int) {
//        self.Country_flag = getCountry
//        self.Message = Message
//        self.splash = splash
//        self.Result = result
//    }
    
}

class SplashList : Codable{
    var Lapse_Time : String?
    var Title : String?
    var Id : Int?
    var Logo: String?
//    init(Lapse_Time: String,Title: String,Id: Int,Logo: String) {
//        self.Lapse_Time = Lapse_Time
//        self.Title = Title
//        self.Id = Id
//        self.Logo = Logo
//    }
    
}




//{
//"session":{"SessionMessage":"Login Valid",
//"SessionResult":1},
//"status":{"Country_flag":"https://www.smartkirana.ca/retailecos/Logo/flag-of-India.png",
//"Message":"Success",
//"Country_Name":"India",
//"splash":[{"Lapse_Time":"2","Title":"Your Retail Partner","Id":"1","Logo":"https://www.smartkirana.ca/retailecos/Logo/ServiceLogoIndia.png"},
//{"Lapse_Time":"2","Title":"Powered By","Id":"2","Logo":"https://www.smartkirana.ca/retailecos/Logo/CompanyLogoIndia.png"},
//{"Lapse_Time":"2","Title":"From","Id":"3","Logo":"https://www.smartkirana.ca/retailecos/Logo/TechnologyLogoIndia.png"}],
//"Result":1}
//}





///mark: getting country ,postal code from google api - model

class ModelToGetCountyPostalCode: Codable {
    var plus_code : PlusCode?
    var results : [Result?]
    var status : String?
}

class PlusCode: Codable {
    var compound_code  : String?
    var global_code : String?
}

class PlusCode2: Codable {
    var compound_code  : String?
    var global_code : String?
}

class Result: Codable {
    var address_components  : [AddressComponent?]
    var formatted_address : String?
    var geometry  : Geometry?
    var place_id : String?
    var plus_code  : PlusCode2?
    var types : [String]
}

class AddressComponent: Codable {
    var long_name  : String?
    var short_name : String?
    var types  : [String]
}
class Geometry: Codable {
    var location  : Location?
    var location_type : String?
    var viewport  : ViewPort?
}

class Location: Codable {
    var lat  : Double?
    var lng  : Double?
}

class Location2: Codable {
    var lat  : Double?
    var lng  : Double?
}
class ViewPort: Codable {
    var northeast  : Location2?
    var southwest  : Location2?
}


//{
//   "plus_code" : {
//      "compound_code" : "QHPV+8C Tenderloin, San Francisco, CA, USA",
//      "global_code" : "849VQHPV+8C"
//   },
//   "results" : [
//      {
//         "address_components" : [
//            {
//               "long_name" : "1277",
//               "short_name" : "1277",
//               "types" : [ "subpremise" ]
//            },
//            {
//               "long_name" : "870",
//               "short_name" : "870",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Market Street",
//               "short_name" : "Market St",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Tenderloin",
//               "short_name" : "Tenderloin",
//               "types" : [ "neighborhood", "political" ]
//            },
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "94102",
//               "short_name" : "94102",
//               "types" : [ "postal_code" ]
//            },
//            {
//               "long_name" : "2918",
//               "short_name" : "2918",
//               "types" : [ "postal_code_suffix" ]
//            }
//         ],
//         "formatted_address" : "870 Market St #1277, San Francisco, CA 94102, USA",
//         "geometry" : {
//            "location" : {
//               "lat" : 37.7858214,
//               "lng" : -122.4064015
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.7871703802915,
//                  "lng" : -122.4050525197085
//               },
//               "southwest" : {
//                  "lat" : 37.7844724197085,
//                  "lng" : -122.4077504802915
//               }
//            }
//         },
//         "place_id" : "ChIJA5OA_YWAhYAR0vL90dPEgzw",
//         "plus_code" : {
//            "compound_code" : "QHPV+8C Tenderloin, San Francisco, CA, USA",
//            "global_code" : "849VQHPV+8C"
//         },
//         "types" : [ "doctor", "establishment", "health", "point_of_interest" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "1800",
//               "short_name" : "1800",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Ellis Street",
//               "short_name" : "Ellis St",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Tenderloin",
//               "short_name" : "Tenderloin",
//               "types" : [ "neighborhood", "political" ]
//            },
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "94115",
//               "short_name" : "94115",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "1800 Ellis St, San Francisco, CA 94115, USA",
//         "geometry" : {
//            "location" : {
//               "lat" : 37.785868,
//               "lng" : -122.4064973
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.7872169802915,
//                  "lng" : -122.4051483197085
//               },
//               "southwest" : {
//                  "lat" : 37.7845190197085,
//                  "lng" : -122.4078462802915
//               }
//            }
//         },
//         "place_id" : "ChIJ4zPXqIiAhYAR31X3S64T6Uw",
//         "plus_code" : {
//            "compound_code" : "QHPV+8C Tenderloin, San Francisco, CA, USA",
//            "global_code" : "849VQHPV+8C"
//         },
//         "types" : [ "street_address" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "1",
//               "short_name" : "1",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Stockton Street",
//               "short_name" : "Stockton St",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Tenderloin",
//               "short_name" : "Tenderloin",
//               "types" : [ "neighborhood", "political" ]
//            },
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "94108",
//               "short_name" : "94108",
//               "types" : [ "postal_code" ]
//            },
//            {
//               "long_name" : "5805",
//               "short_name" : "5805",
//               "types" : [ "postal_code_suffix" ]
//            }
//         ],
//         "formatted_address" : "1 Stockton St, San Francisco, CA 94108, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.7859611,
//                  "lng" : -122.406372
//               },
//               "southwest" : {
//                  "lat" : 37.78575,
//                  "lng" : -122.4066977
//               }
//            },
//            "location" : {
//               "lat" : 37.7858605,
//               "lng" : -122.4065221
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.7872045302915,
//                  "lng" : -122.4051858697085
//               },
//               "southwest" : {
//                  "lat" : 37.7845065697085,
//                  "lng" : -122.4078838302915
//               }
//            }
//         },
//         "place_id" : "ChIJGxvaqIiAhYARpvngxoWeUJo",
//         "types" : [ "premise" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "15-1",
//               "short_name" : "15-1",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Stockton Street",
//               "short_name" : "Stockton St",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Tenderloin",
//               "short_name" : "Tenderloin",
//               "types" : [ "neighborhood", "political" ]
//            },
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "94108",
//               "short_name" : "94108",
//               "types" : [ "postal_code" ]
//            },
//            {
//               "long_name" : "5805",
//               "short_name" : "5805",
//               "types" : [ "postal_code_suffix" ]
//            }
//         ],
//         "formatted_address" : "15-1 Stockton St, San Francisco, CA 94108, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.7858595,
//                  "lng" : -122.4062345
//               },
//               "southwest" : {
//                  "lat" : 37.7857198,
//                  "lng" : -122.4062684
//               }
//            },
//            "location" : {
//               "lat" : 37.7857897,
//               "lng" : -122.4062514
//            },
//            "location_type" : "GEOMETRIC_CENTER",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.78713863029149,
//                  "lng" : -122.4049024697085
//               },
//               "southwest" : {
//                  "lat" : 37.7844406697085,
//                  "lng" : -122.4076004302915
//               }
//            }
//         },
//         "place_id" : "ChIJN56wp4iAhYARYLIfp1_YROA",
//         "types" : [ "route" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Tenderloin",
//               "short_name" : "Tenderloin",
//               "types" : [ "neighborhood", "political" ]
//            },
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Tenderloin, San Francisco, CA, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.7878162,
//                  "lng" : -122.4046888
//               },
//               "southwest" : {
//                  "lat" : 37.780043,
//                  "lng" : -122.421416
//               }
//            },
//            "location" : {
//               "lat" : 37.7846598,
//               "lng" : -122.4145058
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.7878162,
//                  "lng" : -122.4046888
//               },
//               "southwest" : {
//                  "lat" : 37.780043,
//                  "lng" : -122.421416
//               }
//            }
//         },
//         "place_id" : "ChIJyzeuaJCAhYARCmK0UthwWrY",
//         "types" : [ "neighborhood", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "94102",
//               "short_name" : "94102",
//               "types" : [ "postal_code" ]
//            },
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "San Francisco, CA 94102, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.789226,
//                  "lng" : -122.4034491
//               },
//               "southwest" : {
//                  "lat" : 37.7694409,
//                  "lng" : -122.429849
//               }
//            },
//            "location" : {
//               "lat" : 37.7786871,
//               "lng" : -122.4212424
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.789226,
//                  "lng" : -122.4034491
//               },
//               "southwest" : {
//                  "lat" : 37.7694409,
//                  "lng" : -122.429849
//               }
//            }
//         },
//         "place_id" : "ChIJs88qnZmAhYARk8u-7t1Sc2g",
//         "types" : [ "postal_code" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "San Francisco, CA, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.9298239,
//                  "lng" : -122.28178
//               },
//               "southwest" : {
//                  "lat" : 37.6398299,
//                  "lng" : -123.173825
//               }
//            },
//            "location" : {
//               "lat" : 37.7749295,
//               "lng" : -122.4194155
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.9298239,
//                  "lng" : -122.28178
//               },
//               "southwest" : {
//                  "lat" : 37.6398299,
//                  "lng" : -123.173825
//               }
//            }
//         },
//         "place_id" : "ChIJIQBpAG2ahYAR_6128GcTUEo",
//         "types" : [ "locality", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "San Francisco County, CA, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.9298239,
//                  "lng" : -122.28178
//               },
//               "southwest" : {
//                  "lat" : 37.6398299,
//                  "lng" : -123.173825
//               }
//            },
//            "location" : {
//               "lat" : 37.7749073,
//               "lng" : -122.4193878
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.9298239,
//                  "lng" : -122.28178
//               },
//               "southwest" : {
//                  "lat" : 37.6398299,
//                  "lng" : -123.173825
//               }
//            }
//         },
//         "place_id" : "ChIJIQBpAG2ahYARUksNqd0_1h8",
//         "types" : [ "administrative_area_level_2", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "San Francisco Peninsula",
//               "short_name" : "San Francisco Peninsula",
//               "types" : [ "establishment", "natural_feature" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "San Francisco Peninsula, California, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.811608,
//                  "lng" : -121.9835243
//               },
//               "southwest" : {
//                  "lat" : 37.2295212,
//                  "lng" : -122.5251532
//               }
//            },
//            "location" : {
//               "lat" : 37.4614629,
//               "lng" : -122.3107517
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.811608,
//                  "lng" : -121.9835243
//               },
//               "southwest" : {
//                  "lat" : 37.2295212,
//                  "lng" : -122.5251532
//               }
//            }
//         },
//         "place_id" : "ChIJYyep9FV2j4ARqfLae7BmREU",
//         "types" : [ "establishment", "natural_feature" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "California, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 42.0095169,
//                  "lng" : -114.131211
//               },
//               "southwest" : {
//                  "lat" : 32.528832,
//                  "lng" : -124.482003
//               }
//            },
//            "location" : {
//               "lat" : 36.778261,
//               "lng" : -119.4179324
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 42.0095169,
//                  "lng" : -114.131211
//               },
//               "southwest" : {
//                  "lat" : 32.528832,
//                  "lng" : -124.482003
//               }
//            }
//         },
//         "place_id" : "ChIJPV4oX_65j4ARVW8IJ6IJUYs",
//         "types" : [ "administrative_area_level_1", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "United States",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 71.5388001,
//                  "lng" : -66.885417
//               },
//               "southwest" : {
//                  "lat" : 18.7763,
//                  "lng" : 170.5957
//               }
//            },
//            "location" : {
//               "lat" : 37.09024,
//               "lng" : -95.712891
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 71.5388001,
//                  "lng" : -66.885417
//               },
//               "southwest" : {
//                  "lat" : 18.7763,
//                  "lng" : 170.5957
//               }
//            }
//         },
//         "place_id" : "ChIJCzYy5IS16lQRQrfeQ5K5Oxw",
//         "types" : [ "country", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "QHPV+8C",
//               "short_name" : "QHPV+8C",
//               "types" : [ "plus_code" ]
//            },
//            {
//               "long_name" : "Tenderloin",
//               "short_name" : "Tenderloin",
//               "types" : [ "neighborhood", "political" ]
//            },
//            {
//               "long_name" : "San Francisco",
//               "short_name" : "SF",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "San Francisco County",
//               "short_name" : "San Francisco County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "QHPV+8C Tenderloin, San Francisco, CA, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 37.785875,
//                  "lng" : -122.406375
//               },
//               "southwest" : {
//                  "lat" : 37.78575,
//                  "lng" : -122.4065
//               }
//            },
//            "location" : {
//               "lat" : 37.785834,
//               "lng" : -122.406417
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 37.78716148029149,
//                  "lng" : -122.4050885197085
//               },
//               "southwest" : {
//                  "lat" : 37.7844635197085,
//                  "lng" : -122.4077864802915
//               }
//            }
//         },
//         "place_id" : "GhIJ3QphNZbkQkARduJyvAKaXsA",
//         "plus_code" : {
//            "compound_code" : "QHPV+8C Tenderloin, San Francisco, CA, USA",
//            "global_code" : "849VQHPV+8C"
//         },
//         "types" : [ "plus_code" ]
//      }
//   ],
//   "status" : "OK"
//}

