//
//  ToDoService.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift

// TODO: Think about creating a Service
//GET /todos?group=[groupname]
//[
//    {
//    group: String
//    title: String
//    description: String
//    priority: String ['low', 'med', 'high']
//    done: Boolean
//    }
//    ...
//]
//
//POST /todos { :group (optional), :title (required), :description (optional), :priority (optional), :done (optional) }
//
//{
//    group: String
//    title: String
//    description: String
//    priority: String ['low', 'med', 'high']
//    done: Boolean
//}
//
//PUT DELETE follows standard CRUD

public enum Result<T> {
    case error(Error)
    case value(T)
}

public struct ToDoTaskResponse: Codable {
    public let objects: [ToDoTask]
}
//public typealias ToDoTaskResponse = [ToDoTask]

public struct TaskToDoService {
    private let networkManager = NetworkManager()

    public init() {}
    public func tasks() -> Observable<Result<ToDoTaskResponse>> {
        guard let url = NSMutableURLRequest(endpoint: .todos, version: .v1, type: .get) else {
            return Observable.just(Result.error(NetworkError(type: .invalidUrl, message: "Could not create url")))
        }
        return networkManager.request(url).map({ (result) -> Result<ToDoTaskResponse> in
            return NetworkDecoder.decodeResult(result)
        })
    }

    func createTask(_ task: LocalToDoTask) -> Observable<Result<Bool>> {
        do {
            let data = try JSONEncoder().encode(task)
            guard let url = NSMutableURLRequest(endpoint: .todos, version: .v1, type: .post, data: data) else {
                return Observable.just(Result.error(NetworkError(type: .invalidUrl, message: "Could not create url")))
            }
            return networkManager.request(url).map({ (result) -> Result<Bool> in
                return NetworkDecoder.decodeBoolResult(result)
            })
        } catch {
            errorLog(error)
            return Observable.just(Result.error(error))
        }
    }

    func updateTask(_ task: ToDoTask) -> Observable<Result<Bool>> {
        do {
            let data = try JSONEncoder().encode(task)
            guard let url = NSMutableURLRequest(endpoint: .todos, version: .v1, type: .put, data: data) else {
                return Observable.just(Result.error(NetworkError(type: .invalidUrl, message: "Could not create url")))
            }
            return networkManager.request(url).map({ (result) -> Result<Bool> in
                return NetworkDecoder.decodeBoolResult(result)
            })
        } catch {
            errorLog(error)
            return Observable.just(Result.error(error))
        }
    }

    func deleteTask(_ task: ToDoTask) -> Observable<Result<Bool>> {
        do {
            let data = try JSONEncoder().encode(task)
            guard let url = NSMutableURLRequest(endpoint: .todos, version: .v1, type: .delete, data: data) else {
                return Observable.just(Result.error(NetworkError(type: .invalidUrl, message: "Could not create url")))
            }
            return networkManager.request(url).map({ (result) -> Result<Bool> in
                return NetworkDecoder.decodeBoolResult(result)
            })
        } catch {
            errorLog(error)
            return Observable.just(Result.error(error))
        }
    }
}
