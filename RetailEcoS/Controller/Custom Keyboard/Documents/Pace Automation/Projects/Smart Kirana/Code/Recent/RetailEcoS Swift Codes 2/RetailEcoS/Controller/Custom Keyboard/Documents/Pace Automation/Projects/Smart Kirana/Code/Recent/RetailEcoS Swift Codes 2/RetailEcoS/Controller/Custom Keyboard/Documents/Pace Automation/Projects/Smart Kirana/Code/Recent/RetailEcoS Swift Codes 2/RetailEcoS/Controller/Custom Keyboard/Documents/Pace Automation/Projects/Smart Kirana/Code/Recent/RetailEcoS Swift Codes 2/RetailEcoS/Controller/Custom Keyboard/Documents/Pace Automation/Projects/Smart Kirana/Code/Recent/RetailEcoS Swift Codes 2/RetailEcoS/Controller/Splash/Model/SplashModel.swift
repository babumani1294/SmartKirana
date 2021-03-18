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
    var Postal_Code_Format : String?
    var Message : String?
    var Country_Name : String?
    var splash: [SplashList]?
    var Result : Int?
}

class SplashList : Codable{
    var Lapse_Time : String?
    var Title : String?
    var Id : Int?
    var Logo: String?
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





//---------

//for chennai 78

//{
//   "plus_code" : {
//      "compound_code" : "25HR+8W Chennai, Tamil Nadu, India",
//      "global_code" : "7M5225HR+8W"
//   },
//   "results" : [
//      {
//         "address_components" : [
//            {
//               "long_name" : "33",
//               "short_name" : "33",
//               "types" : [ "premise" ]
//            },
//            {
//               "long_name" : "Doctor Khanu Nagar 4th Street",
//               "short_name" : "Dr Khanu Nagar 4th St",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Indira Nagar",
//               "short_name" : "Indira Nagar",
//               "types" : [ "political", "sublocality", "sublocality_level_3" ]
//            },
//            {
//               "long_name" : "Indira Nagar",
//               "short_name" : "Indira Nagar",
//               "types" : [ "political", "sublocality", "sublocality_level_2" ]
//            },
//            {
//               "long_name" : "Jaffarkhanpet",
//               "short_name" : "Jaffarkhanpet",
//               "types" : [ "political", "sublocality", "sublocality_level_1" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Tiruvallur",
//               "short_name" : "Tiruvallur",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Tamil Nadu",
//               "short_name" : "Tamil Nadu",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "India",
//               "short_name" : "IN",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "600078",
//               "short_name" : "600078",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "33, Dr Khanu Nagar 4th St, Indira Nagar, Jaffarkhanpet, Chennai, Tamil Nadu 600078, India",
//         "geometry" : {
//            "location" : {
//               "lat" : 13.0283527,
//               "lng" : 80.1922931
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.0297016802915,
//                  "lng" : 80.19364208029151
//               },
//               "southwest" : {
//                  "lat" : 13.0270037197085,
//                  "lng" : 80.1909441197085
//               }
//            }
//         },
//         "place_id" : "ChIJAfjA8CtnUjoRY9eCHKt5skc",
//         "plus_code" : {
//            "compound_code" : "25HR+8W Chennai, Tamil Nadu, India",
//            "global_code" : "7M5225HR+8W"
//         },
//         "types" : [ "street_address" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "4th Street",
//               "short_name" : "4th St",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Indira Nagar",
//               "short_name" : "Indira Nagar",
//               "types" : [ "political", "sublocality", "sublocality_level_3" ]
//            },
//            {
//               "long_name" : "Kanu Nagar",
//               "short_name" : "Kanu Nagar",
//               "types" : [ "political", "sublocality", "sublocality_level_2" ]
//            },
//            {
//               "long_name" : "Manapakkam",
//               "short_name" : "Manapakkam",
//               "types" : [ "political", "sublocality", "sublocality_level_1" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//            },
//            {
//               "long_name" : "600089",
//               "short_name" : "600089",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "4th St, Indira Nagar, Kanu Nagar, Manapakkam, Chennai, Tamil Nadu 600089, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.0283037,
//                  "lng" : 80.19240549999999
//               },
//               "southwest" : {
//                  "lat" : 13.0282587,
//                  "lng" : 80.19116219999999
//               }
//            },
//            "location" : {
//               "lat" : 13.028269,
//               "lng" : 80.1917844
//            },
//            "location_type" : "GEOMETRIC_CENTER",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.0296301802915,
//                  "lng" : 80.1931328302915
//               },
//               "southwest" : {
//                  "lat" : 13.0269322197085,
//                  "lng" : 80.1904348697085
//               }
//            }
//         },
//         "place_id" : "ChIJ0Q_17StnUjoRrEXyGQxoQmU",
//         "types" : [ "route" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Indira Nagar",
//               "short_name" : "Indira Nagar",
//               "types" : [ "political", "sublocality", "sublocality_level_3" ]
//            },
//            {
//               "long_name" : "Kanu Nagar",
//               "short_name" : "Kanu Nagar",
//               "types" : [ "political", "sublocality", "sublocality_level_2" ]
//            },
//            {
//               "long_name" : "Manapakkam",
//
//               "short_name" : "Manapakkam",
//               "types" : [ "political", "sublocality", "sublocality_level_1" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//            },
//            {
//               "long_name" : "600089",
//               "short_name" : "600089",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "Indira Nagar, Kanu Nagar, Manapakkam, Chennai, Tamil Nadu 600089, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.0286912,
//                  "lng" : 80.19335930000001
//               },
//               "southwest" : {
//                  "lat" : 13.0278442,
//                  "lng" : 80.19115979999999
//               }
//            },
//            "location" : {
//               "lat" : 13.0282653,
//               "lng" : 80.1920398
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.0296166802915,
//                  "lng" : 80.19360853029151
//               },
//               "southwest" : {
//                  "lat" : 13.0269187197085,
//                  "lng" : 80.19091056970851
//               }
//            }
//         },
//         "place_id" : "ChIJ-TDx8CtnUjoRMi8UZVcZUX0",
//         "types" : [ "political", "sublocality", "sublocality_level_3" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Bharathi Nagar",
//               "short_name" : "Bharathi Nagar",
//               "types" : [ "political", "sublocality", "sublocality_level_2" ]
//            },
//            {
//               "long_name" : "Manapakkam",
//               "short_name" : "Manapakkam",
//               "types" : [ "political", "sublocality", "sublocality_level_1" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//            },
//            {
//               "long_name" : "600089",
//               "short_name" : "600089",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "Bharathi Nagar, Manapakkam, Chennai, Tamil Nadu 600089, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.0313729,
//                  "lng" : 80.1934629
//               },
//               "southwest" : {
//                  "lat" : 13.028289,
//                  "lng" : 80.1911891
//               }
//            },
//            "location" : {
//               "lat" : 13.0297453,
//               "lng" : 80.1924248
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.0313729,
//                  "lng" : 80.19367498029152
//               },
//               "southwest" : {
//                  "lat" : 13.028289,
//                  "lng" : 80.19097701970851
//               }
//            }
//         },
//         "place_id" : "ChIJG_AJzitnUjoRZ7DBia7tAv4",
//         "types" : [ "political", "sublocality", "sublocality_level_2" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Nesapakkam",
//               "short_name" : "Nesapakkam",
//               "types" : [ "political", "sublocality", "sublocality_level_1" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//         "formatted_address" : "Nesapakkam, Chennai, Tamil Nadu, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.041935,
//                  "lng" : 80.20301189999999
//               },
//               "southwest" : {
//                  "lat" : 13.0276928,
//                  "lng" : 80.18386199999999
//               }
//            },
//            "location" : {
//               "lat" : 13.0379385,
//               "lng" : 80.1919681
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.041935,
//                  "lng" : 80.20301189999999
//               },
//               "southwest" : {
//                  "lat" : 13.0276928,
//                  "lng" : 80.18386199999999
//               }
//            }
//         },
//         "place_id" : "ChIJc23r5CphUjoRnXXO8d9fHAY",
//         "types" : [ "political", "sublocality", "sublocality_level_1" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "600089",
//               "short_name" : "600089",
//               "types" : [ "postal_code" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Tiruvallur",
//               "short_name" : "Tiruvallur",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//         "formatted_address" : "Chennai, Tamil Nadu 600089, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.0365804,
//                  "lng" : 80.2034645
//               },
//               "southwest" : {
//                  "lat" : 13.0013716,
//                  "lng" : 80.1695213
//               }
//            },
//            "location" : {
//               "lat" : 13.0180773,
//               "lng" : 80.18702239999999
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.0365804,
//                  "lng" : 80.2034645
//               },
//               "southwest" : {
//                  "lat" : 13.0013716,
//                  "lng" : 80.1695213
//               }
//            }
//         },
//         "place_id" : "ChIJ513i6TJnUjoRbiM1D5tMZkc",
//         "types" : [ "postal_code" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//         "formatted_address" : "Chennai, Tamil Nadu, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.2611661,
//                  "lng" : 80.33632279999999
//               },
//               "southwest" : {
//                  "lat" : 12.8338848,
//                  "lng" : 80.0817007
//               }
//            },
//            "location" : {
//               "lat" : 13.0826802,
//               "lng" : 80.27071840000001
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.2611661,
//                  "lng" : 80.33632279999999
//               },
//               "southwest" : {
//                  "lat" : 12.8338848,
//                  "lng" : 80.0817007
//               }
//            }
//         },
//         "place_id" : "ChIJYTN9T-plUjoRM9RjaAunYW4",
//         "types" : [ "locality", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Tiruvallur",
//               "short_name" : "Tiruvallur",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//         "formatted_address" : "Tiruvallur, Tamil Nadu, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.5653538,
//                  "lng" : 80.3533479
//               },
//               "southwest" : {
//                  "lat" : 12.927394,
//                  "lng" : 79.28749569999999
//               }
//            },
//            "location" : {
//               "lat" : 13.2544335,
//               "lng" : 80.0087746
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.5653538,
//                  "lng" : 80.3533479
//               },
//               "southwest" : {
//                  "lat" : 12.927394,
//                  "lng" : 79.28749569999999
//               }
//            }
//         },
//         "place_id" : "ChIJdQx5zBCQUjoR-L9nLEtv1I0",
//         "types" : [ "administrative_area_level_2", "political" ]
//      },
//      {
//         "address_components" : [
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
//         "formatted_address" : "Tamil Nadu, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.496666,
//                  "lng" : 80.3464511
//               },
//               "southwest" : {
//                  "lat" : 8.0690069,
//                  "lng" : 76.23055409999999
//               }
//            },
//            "location" : {
//               "lat" : 11.1271225,
//               "lng" : 78.6568942
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.496666,
//                  "lng" : 80.3464511
//               },
//               "southwest" : {
//                  "lat" : 8.0690069,
//                  "lng" : 76.23055409999999
//               }
//            }
//         },
//         "place_id" : "ChIJM5YYsYLFADsR8GEzRsx1lFU",
//         "types" : [ "administrative_area_level_1", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "India",
//               "short_name" : "IN",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 35.513327,
//                  "lng" : 97.39535869999999
//               },
//               "southwest" : {
//                  "lat" : 6.4626999,
//                  "lng" : 68.1097
//               }
//            },
//            "location" : {
//               "lat" : 20.593684,
//               "lng" : 78.96288
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 35.513327,
//                  "lng" : 97.39535869999999
//               },
//               "southwest" : {
//                  "lat" : 6.4626999,
//                  "lng" : 68.1097
//               }
//            }
//         },
//         "place_id" : "ChIJkbeSa_BfYzARphNChaFPjNc",
//         "types" : [ "country", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "25HR+8W",
//               "short_name" : "25HR+8W",
//               "types" : [ "plus_code" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Chennai",
//               "short_name" : "Chennai",
//               "types" : [ "administrative_area_level_2", "political" ]
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
//         "formatted_address" : "25HR+8W Chennai, Tamil Nadu, India",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 13.028375,
//                  "lng" : 80.192375
//               },
//               "southwest" : {
//                  "lat" : 13.02825,
//                  "lng" : 80.19225
//               }
//            },
//            "location" : {
//               "lat" : 13.0283707,
//               "lng" : 80.1923446
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 13.0296614802915,
//                  "lng" : 80.1936614802915
//
//               },
//               "southwest" : {
//                  "lat" : 13.0269635197085,
//                  "lng" : 80.19096351970849
//               }
//            }
//         },
//         "place_id" : "GhIJSlS5moYOKkAR-6O5X08MVEA",
//         "plus_code" : {
//            "compound_code" : "25HR+8W Chennai, Tamil Nadu, India",
//            "global_code" : "7M5225HR+8W"
//         },
//         "types" : [ "plus_code" ]
//      }
//   ],
//   "status" : "OK"
//}





//------------

//for  canada

//{
//   "plus_code" : {
//      "compound_code" : "WGCP+CW Richmond Hill, ON, Canada",
//      "global_code" : "87M2WGCP+CW"
//   },
//   "results" : [
//      {
//         "address_components" : [
//            {
//               "long_name" : "58",
//               "short_name" : "58",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Lake Forest Drive",
//               "short_name" : "Lake Forest Dr",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Richmond Hill",
//               "short_name" : "Richmond Hill",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "L4E 0A8",
//               "short_name" : "L4E 0A8",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "58 Lake Forest Dr, Richmond Hill, ON L4E 0A8, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 43.9213552,
//                  "lng" : -79.4615147
//               },
//               "southwest" : {
//                  "lat" : 43.9211919,
//                  "lng" : -79.46180819999999
//               }
//            },
//            "location" : {
//               "lat" : 43.9212812,
//               "lng" : -79.461643
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.9226225302915,
//                  "lng" : -79.46031246970848
//               },
//               "southwest" : {
//                  "lat" : 43.9199245697085,
//                  "lng" : -79.46301043029149
//               }
//            }
//         },
//         "place_id" : "ChIJ3we71vrVKogRBC3D_-4tvic",
//         "types" : [ "premise" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "54",
//               "short_name" : "54",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Lake Forest Drive",
//               "short_name" : "Lake Forest Dr",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Richmond Hill",
//               "short_name" : "Richmond Hill",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "L4E 0A8",
//               "short_name" : "L4E 0A8",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "54 Lake Forest Dr, Richmond Hill, ON L4E 0A8, Canada",
//         "geometry" : {
//            "location" : {
//               "lat" : 43.9215308,
//               "lng" : -79.46166150000001
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.9228797802915,
//                  "lng" : -79.46031251970851
//               },
//               "southwest" : {
//                  "lat" : 43.9201818197085,
//                  "lng" : -79.46301048029152
//               }
//            }
//         },
//         "place_id" : "ChIJKYmW1PrVKogRv4Znv1BbQ4g",
//         "plus_code" : {
//            "compound_code" : "WGCQ+J8 Richmond Hill, ON, Canada",
//            "global_code" : "87M2WGCQ+J8"
//         },
//         "types" : [ "street_address" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "58",
//               "short_name" : "58",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Lake Forest Drive",
//               "short_name" : "Lake Forest Dr",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Richmond Hill",
//               "short_name" : "Richmond Hill",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "L4E 0A8",
//               "short_name" : "L4E 0A8",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "58 Lake Forest Dr, Richmond Hill, ON L4E 0A8, Canada",
//         "geometry" : {
//            "location" : {
//               "lat" : 43.9213455,
//               "lng" : -79.46133640000001
//            },
//            "location_type" : "RANGE_INTERPOLATED",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.9226944802915,
//                  "lng" : -79.45998741970851
//               },
//               "southwest" : {
//                  "lat" : 43.9199965197085,
//                  "lng" : -79.46268538029152
//               }
//            }
//         },
//         "place_id" : "EjQ1OCBMYWtlIEZvcmVzdCBEciwgUmljaG1vbmQgSGlsbCwgT04gTDRFIDBBOCwgQ2FuYWRhIhoSGAoUChIJJVcGz_rVKogRLim8aCEOcJ0QOg",
//         "types" : [ "street_address" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "44-72",
//               "short_name" : "44-72",
//               "types" : [ "street_number" ]
//            },
//            {
//               "long_name" : "Lake Forest Drive",
//               "short_name" : "Lake Forest Dr",
//               "types" : [ "route" ]
//            },
//            {
//               "long_name" : "Richmond Hill",
//               "short_name" : "Richmond Hill",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            },
//            {
//               "long_name" : "L4E 0A8",
//               "short_name" : "L4E 0A8",
//               "types" : [ "postal_code" ]
//            }
//         ],
//         "formatted_address" : "44-72 Lake Forest Dr, Richmond Hill, ON L4E 0A8, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 43.92202160000001,
//                  "lng" : -79.46065129999999
//               },
//               "southwest" : {
//                  "lat" : 43.9201497,
//                  "lng" : -79.4614613
//               }
//            },
//            "location" : {
//               "lat" : 43.9212579,
//               "lng" : -79.46130099999999
//            },
//            "location_type" : "GEOMETRIC_CENTER",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.92243463029151,
//                  "lng" : -79.45970731970849
//               },
//               "southwest" : {
//                  "lat" : 43.91973666970851,
//                  "lng" : -79.46240528029149
//               }
//            }
//         },
//         "place_id" : "ChIJJVcGz_rVKogRLim8aCEOcJ0",
//         "types" : [ "route" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "L4E 0A8",
//               "short_name" : "L4E 0A8",
//               "types" : [ "postal_code" ]
//            },
//            {
//               "long_name" : "Richmond Hill",
//               "short_name" : "Richmond Hill",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Richmond Hill, ON L4E 0A8, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 43.9240879,
//                  "lng" : -79.4603297
//               },
//               "southwest" : {
//                  "lat" : 43.9195019,
//                  "lng" : -79.46466319999999
//               }
//            },
//            "location" : {
//               "lat" : 43.921117,
//               "lng" : -79.4626538
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.9240879,
//                  "lng" : -79.4603297
//               },
//               "southwest" : {
//                  "lat" : 43.9195019,
//                  "lng" : -79.46466319999999
//               }
//            }
//         },
//         "place_id" : "ChIJ47ZjIuXVKogRVSJO1aJcbC0",
//         "types" : [ "postal_code" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "L4E",
//               "short_name" : "L4E",
//               "types" : [ "postal_code", "postal_code_prefix" ]
//            },
//            {
//               "long_name" : "Gormley",
//               "short_name" : "Gormley",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Gormley, ON L4E, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 43.977672,
//                  "lng" : -79.3888431
//               },
//               "southwest" : {
//                  "lat" : 43.90248,
//                  "lng" : -79.486577
//               }
//            },
//            "location" : {
//               "lat" : 43.9381619,
//               "lng" : -79.43663239999999
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.977672,
//                  "lng" : -79.3888431
//               },
//               "southwest" : {
//                  "lat" : 43.90248,
//                  "lng" : -79.486577
//               }
//            }
//         },
//         "place_id" : "ChIJy3lON7DVKogRghMiAYRPLoE",
//         "postcode_localities" : [ "Gormley", "Richmond Hill" ],
//         "types" : [ "postal_code", "postal_code_prefix" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Richmond Hill",
//               "short_name" : "Richmond Hill",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Richmond Hill, ON, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 43.9777849,
//                  "lng" : -79.37100989999999
//               },
//               "southwest" : {
//                  "lat" : 43.829353,
//                  "lng" : -79.48559299999999
//               }
//            },
//            "location" : {
//               "lat" : 43.8828401,
//               "lng" : -79.4402808
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.9777849,
//                  "lng" : -79.37100989999999
//               },
//               "southwest" : {
//                  "lat" : 43.829353,
//                  "lng" : -79.48559299999999
//               }
//            }
//         },
//         "place_id" : "ChIJMxcpNkkqK4gR7UKx1gp2AVI",
//         "types" : [ "locality", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Regional Municipality of York, ON, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 44.433499,
//                  "lng" : -79.1560961
//               },
//               "southwest" : {
//                  "lat" : 43.749899,
//                  "lng" : -79.775515
//               }
//            },
//            "location" : {
//               "lat" : 43.9884612,
//               "lng" : -79.4703885
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 44.433499,
//                  "lng" : -79.1560961
//               },
//               "southwest" : {
//                  "lat" : 43.749899,
//                  "lng" : -79.775515
//               }
//            }
//         },
//         "place_id" : "ChIJeabS5K7NKogRZIooarTPjRA",
//         "types" : [ "administrative_area_level_2", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Ontario, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 56.931393,
//                  "lng" : -74.3206479
//               },
//               "southwest" : {
//                  "lat" : 41.6765559,
//                  "lng" : -95.1562271
//               }
//            },
//            "location" : {
//               "lat" : 51.253775,
//               "lng" : -85.32321399999999
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 56.931393,
//                  "lng" : -74.3206479
//               },
//               "southwest" : {
//                  "lat" : 41.6765559,
//                  "lng" : -95.1562271
//               }
//            }
//         },
//         "place_id" : "ChIJrxNRX7IFzkwRCR5iKVZC-HA",
//         "types" : [ "administrative_area_level_1", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 83.63809999999999,
//                  "lng" : -50.9766
//               },
//               "southwest" : {
//                  "lat" : 41.6765559,
//                  "lng" : -141.00187
//               }
//            },
//            "location" : {
//               "lat" : 56.130366,
//               "lng" : -106.346771
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 83.63809999999999,
//                  "lng" : -50.9766
//               },
//               "southwest" : {
//                  "lat" : 41.6765559,
//                  "lng" : -141.00187
//               }
//            }
//         },
//         "place_id" : "ChIJ2WrMN9MDDUsRpY9Doiq3aJk",
//         "types" : [ "country", "political" ]
//      },
//      {
//         "address_components" : [
//            {
//               "long_name" : "WGCP+CW",
//               "short_name" : "WGCP+CW",
//               "types" : [ "plus_code" ]
//            },
//            {
//               "long_name" : "Richmond Hill",
//               "short_name" : "Richmond Hill",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Regional Municipality of York",
//               "short_name" : "Regional Municipality of York",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "Ontario",
//               "short_name" : "ON",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "Canada",
//               "short_name" : "CA",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "WGCP+CW Richmond Hill, ON, Canada",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 43.921125,
//                  "lng" : -79.462625
//               },
//               "southwest" : {
//                  "lat" : 43.921,
//                  "lng" : -79.46275
//               }
//            },
//            "location" : {
//               "lat" : 43.921117,
//               "lng" : -79.4626538
//            },
//            "location_type" : "ROOFTOP",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 43.9224114802915,
//                  "lng" : -79.46133851970849
//               },
//               "southwest" : {
//                  "lat" : 43.9197135197085,
//                  "lng" : -79.4640364802915
//               }
//            }
//         },
//         "place_id" : "GhIJE2VvKef1RUARsBevHpzdU8A",
//         "plus_code" : {
//            "compound_code" : "WGCP+CW Richmond Hill, ON, Canada",
//            "global_code" : "87M2WGCP+CW"
//         },
//         "types" : [ "plus_code" ]
//      }
//   ],
//   "status" : "OK"
//}
