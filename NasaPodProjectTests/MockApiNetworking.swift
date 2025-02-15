//
//  MockApiNetworking.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 15/01/2025.
//

import XCTest
@testable import NasaPodProject

class MockApiNetworking: ApiNetworking {
  var recentPicturesResult: Result<[PictureOfTheDay], Error> = .success([])

  var result: Result<PictureOfTheDay, Error> = .success(PictureOfTheDay(
    copyright: "",
    date: "",
    title: "",
    explanation: "",
    url: "",
    mediaType: ""
  ))

  override func fetchPictureOfTheDay(completion: @escaping (Result<PictureOfTheDay, Error>) -> Void) {
    completion(result)
  }

  override func fetchRecentPictures(completion: @escaping ([PictureOfTheDay]) -> Void) {
    switch recentPicturesResult {
    case .success(let picturesData):
      completion(picturesData)
    case .failure(let error):
      print(error)
      completion([])
    }
  }
}
