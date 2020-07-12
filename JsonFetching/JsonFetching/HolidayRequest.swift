//
//  HolidayRequest.swift
//  JsonFetching
//
//  Created by apple on 12/07/20.
//  Copyright © 2020 com.rohit. All rights reserved.
//

import Foundation

enum HolidayError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "8403c469a891b90d7a3630ceadbc6dd9dc92d7bb"
    
    
    init(countryCode:String) {
        
//        let date = Date()
//        let format = DateFormatter()
//        format.dateFormat = "yyyy"
//        let currentYear = format.string(from: date)
//        print(currentYear)
//
       
        let year = Calendar.current.component(.year, from: Date())
        
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(year)"
        
        
        guard let resourceURL = URL(string: resourceString) else{ fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getHoliday (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            print(data)
            do{
            let decoder = JSONDecoder()
               let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
//                let holidaysResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                print(holidaysResponse)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
                print(holidayDetails)
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
        
    }
}
