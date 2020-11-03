//
//  ViewController.swift
//  GetServiceData
//
//  Created by Zeeshan Munir on 03/11/2020.
//

import UIKit
//import Alamofire

struct ContactModel: Decodable {
    let contacts: [Contact]
}
struct Contact: Decodable {
    let id, name, email, address, gender: String
    let phone: Phone
}
struct Phone: Decodable {
    let mobile, home, office: String
}

class ViewController: UIViewController {
    let url = URL(string: "https://api.androidhive.info/contacts/")
    weak var contactsTask:  URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        serviceCheck()
          getData()
        }
    
//    func getDataUsingAlamophire(){
//        AF.request("https://api.androidhive.info/contacts/").responseJSON { ContactModel in
//           debugPrint(ContactModel)
//    }
//        getDataUsingAlamophire()

    func getData() {
        guard let url = url else {
            return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                if let data = data{
                do {
                    let newsFeed = try JSONDecoder().decode(ContactModel.self, from: data)
                    print("\(newsFeed)")
                } catch {
                    print("Error in parsing")
                }
            }
                else{
                    print("error in data")
            }
        }
    }
        task.resume()
//        contactsTask = task
}

    func serviceCheck() {
        if (contactsTask?.state == .running)  {
            contactsTask?.cancel()
        }
        getData()
   }
}


