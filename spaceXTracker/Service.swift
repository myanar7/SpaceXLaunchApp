//
//  Service.swift
//  spaceXTracker
//
//  Created by Mustafa Yanar on 2.10.2023.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    private let serviceUrl = "https://api.spacexdata.com/v4/launches/latest"
    
    func request(completion: @escaping (SpaceXLaunchInfo) -> Void) {
        // Define the URL for the SpaceX API endpoint
        if let url = URL(string: serviceUrl) {
            // Create a URLSession instance
            let session = URLSession.shared

            // Create a data task to send the request and retrieve the data
            let task = session.dataTask(with: url) { (data, response, error) in
                // Check for errors
                if let error = error {
                    print("Error: (error)")
                    return
                }

                // Check if a response was received
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("No HTTP response")
                    return
                }

                // Check if the status code indicates success (e.g., 200 OK)
                if httpResponse.statusCode == 200 {
                    // Check if data was returned
                    if let data = data {
                        // Parse the JSON data if needed (assuming it's JSON)
                        guard let json = try? JSONDecoder().decode(SpaceXLaunchInfo.self, from: data) else { return }
                        // Now you can work with the JSON data
                        completion(json)
                        print(json)
                    } else {
                        print("No data received")
                    }
                } else {
                    print("HTTP status code: (httpResponse.statusCode)")
                }
            }

            // Start the data task
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}
