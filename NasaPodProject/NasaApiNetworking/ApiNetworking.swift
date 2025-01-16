//
//  ApiNetworking.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//

import Foundation


class ApiNetworking {
    static let shared = ApiNetworking()
    private let baseURL = "https://api.nasa.gov/planetary/apod"
    private let apiKey = "DEMO_API"
    
    func fetchPictureOfTheDay(completion: @escaping (Result<PictureOfTheDay, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }

            do {
                let pictureData = try JSONDecoder().decode(PictureOfTheDay.self, from: data)
                completion(.success(pictureData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }



    func fetchRecentPictures(completion: @escaping ([PictureOfTheDay]) -> Void) {

        let startDateString = getStartDate()
        let endDateString = getTodaysDate()


        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)&start_date=\(startDateString)&end_date=\(endDateString)") else {
            completion([])
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion([])
                return
            }

            let picturesData = (try? JSONDecoder().decode([PictureOfTheDay].self, from: data)) ?? []
            completion(picturesData)
        }.resume()
    }
}
