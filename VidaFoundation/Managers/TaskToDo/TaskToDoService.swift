//
//  ToDoService.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift

// TODO: How do we handle local changes and keep the app working while server is unavailable (Need proposal)
//  - could: save locally to cache, retry calls when network, if failure, invalidate cache and pull from network 
internal struct TaskToDoService {
    private let networkManager = NetworkManager()
    private let storage = GlobalStorage()

    public init() {
        // TODO Alex: Think about what to send in no cache, first time.
        if let tasks: [ToDoTask] = storage.object(forKey: GlobalStorage.Keys.tasks) {
            cachedTasks = BehaviorSubject.init(value: Result.value(tasks))
            return
        } else {
            cachedTasks = BehaviorSubject.init(value: Result.value([]))
        }
    }

    var cachedTasks: BehaviorSubject<Result<[ToDoTask]>>

    private func networkTasks() -> Observable<Result<ToDoTaskResponse>> {
        
        guard let url = NSMutableURLRequest(endpoint: .todos, version: .v1, type: .get) else {
            return Observable.just(Result.error(NetworkError(type: .invalidUrl, message: "Could not create url")))
        }
        return networkManager.request(url).map({ (result) -> Result<ToDoTaskResponse> in
            return NetworkDecoder.decodeResult(result)
        })
    }

    // subscribing to this causes the network request to send.
    public func tasks() -> Observable<Result<[ToDoTask]>> {
        return networkTasks().map { (result) -> Result<[ToDoTask]> in
            switch result {
            case .error(let error):
                return Result.error(error)
            case .value(let response):
                return Result.value(response.objects)
            }
        }
    }

    // TODO Alex: Using the cache was hanging the app (Alex, one day)
//    func tasks() -> Observable<Result<[ToDoTask]>> {
//            return cachedTasks
//                .do(onNext: { result in
//                    switch result {
//                    case .value(let list): //update cache
//                        do {
//                            let encodedTasks = try JSONEncoder().encode(list)
//                            self.storage.set(encodedTasks, forKey: GlobalStorage.Keys.tasks)
//                        } catch {
//                            errorLog("Could not encode task list data.")
//                        }
//                    case .error(let error): // log error
//                        errorLog(error)
//                    }
//                },
//                    onSubscribed: refreshTasks)
//                .map {result in
//                    switch result {
//                    case .error(let error):
//                        return Result.error(error)
//                    case .value(let taskList):
//                        return Result.value(taskList)
//                    }
//                }
//    }

    fileprivate func refreshTasks() {
        // TOOD Alex: Dispose of this
        _ = networkTasks()
            .subscribe(onNext: { result in
                guard case .value(let tasks) = result else {
                    self.cachedTasks.onNext(Result.value([]))
                    return
                }
                self.cachedTasks.onNext(Result.value(tasks.objects))
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
