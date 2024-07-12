//
//  ImageLoader.swift
//  YBSChallenge
//
//  Created by Travis Lai on 8/7/2024.
//

import Foundation
import UIKit

final class ImageLoader {
    
    private func handleResponse(data: Data?, response: URLResponse?) -> Photos? {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        
        do {
            let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
            return photosResponse.photos
        } catch {
            return nil
        }
    }
    
    private func handleGetUserResponse(data: Data?, response: URLResponse?) -> User? {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        
        do {
            let userResponse = try JSONDecoder().decode(User.self, from: data)
            return userResponse
        } catch {
            return nil
        }
    }
    
    func searchImages(tag: String = "yorkshire") async throws -> Photos? {
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=917958ef489fa0a2b5c6fe531e28f4fd&tags=\(tag)&safe_search=1&format=json&nojsoncallback=1") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        return handleResponse(data: data, response: response)
    }
    
    func getPhotoInfo(photoId: String, secret: String) async throws -> PhotoInfo? {
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=917958ef489fa0a2b5c6fe531e28f4fd&photo_id=\(photoId)&secret=\(secret)&format=json&nojsoncallback=1") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        
        do {
            let photoInfoResponse = try JSONDecoder().decode(PhotoInfoResponse.self, from: data)
            return photoInfoResponse.photoInfo
        } catch {
            return nil
        }
    }
}
