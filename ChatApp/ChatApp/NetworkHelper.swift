//
//  NetworkHelper.swift
//  ChatApp
//
//  Created by Tihomir RAdeff on 11.03.24.
//

import Foundation

class NetworkHelper {
    
    static func downloadData(fileName: String) -> String {
        let urlString = "https://radefffactory.com/Documents/" + fileName + ".txt"
        let url = URL(string: urlString)
        
        var webString: String = ""
        do {
            webString = try String(contentsOf: url!)
            return webString
        } catch {
            print("Error downloading file!")
            return webString
        }
    }
    
    static func sendData(fileName: String, message: String, completition: @escaping (String) -> Void) -> Void {
        let url = URL(string: "https://radefffactory.com/Documents/add_data.php")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "file", value: fileName + ".txt"),
            URLQueryItem(name: "message", value: message)
        ]
        let query = components.url!.query
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query!.utf8)
        
        var status = "ERROR"
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                completition(status)
                return
            }
            
            guard let data = data else {
                completition(status)
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            status = "SUCCESS"
            completition(status)
        })
        task.resume()
    }
}
