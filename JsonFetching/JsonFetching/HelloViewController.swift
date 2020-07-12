//
//  ViewController.swift
//  JsonFetching
//
//  Created by apple on 12/07/20.
//  Copyright © 2020 com.rohit. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchDate: UISearchBar!
    
  var listOfHoliday = [HolidayDetail](){
           didSet {
               DispatchQueue.main.async {
                   self.tableView.reloadData()
                   self.navigationItem.title = "\(self.listOfHoliday.count) holidays found"
               }
           }
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           searchDate.delegate = self
           // Do any additional setup after loading the view.
        searchDate.backgroundColor = .cyan
       }
       
       func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return  listOfHoliday.count
       }
       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           let holiday = listOfHoliday[indexPath.row]
           cell.textLabel?.text = holiday.name
           cell.detailTextLabel?.text = holiday.date.iso
           
            print(listOfHoliday)
       return cell
       }


   }
   extension HelloViewController: UISearchBarDelegate{
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           guard let searchBarText = searchDate.text else{return}
           
           let holidayRequest = HolidayRequest(countryCode: searchBarText)
           holidayRequest.getHoliday { [weak self] result in
               switch result {
               case.failure(let error):
                   print(error)
               case.success(let holidays):
                   self?.listOfHoliday = holidays
               }
               
           }
           
       }


}

