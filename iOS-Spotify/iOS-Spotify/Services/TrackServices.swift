//
//  TrackServices.swift
//  iOS-Spotify
//
//  Created by Ignatio Julian on 25/05/21.
// https://api.spotify.com/v1/tracks

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

class TrackService {
    func getTrackByQuery(parameters: String, offset: Int, limit: Int) -> Observable<TrackResponse> {
        return Observable<TrackResponse>.create { observer -> Disposable in
            let request = Alamofire
                .request("https://api.spotify.com/v1/search?q=\(parameters)&type=track&offset=\(offset)&limit=\(limit)", method: .get)
                .validate()
                .responseObject(completionHandler: { (response: DataResponse<TrackResponse>) in
                    switch response.result {
                    case .success(let trackResponse):
                        observer.onNext(trackResponse)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            return Disposables.create(with: {
                request.cancel()
            })
        }
    };
}
