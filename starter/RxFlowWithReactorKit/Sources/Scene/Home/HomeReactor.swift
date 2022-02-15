//
//  HomeReactor.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import Foundation

import RxFlow
import RxCocoa
import ReactorKit

final class HomeReactor: Reactor, Stepper {
	
	// MARK: Stepper
	
	var steps: PublishRelay<Step> = .init()
	
	// MARK: Events
	
	enum Action {

	}
	
	enum Mutation {
		case setMeta(_ meta: MetaData)
		case setMovies(_ movies: [Movie])
		case setError(error: Error)
	}
	
	struct State {
		var meta: MetaData?
		var movies: [Movie]?
	}
	
	// MARK: Properties
	
	let initialState: State
	private let provider: ServiceProviderType
	
	let errorSubject: PublishSubject<Error> = .init()
	
	init(provider: ServiceProviderType) {
		initialState = State()
		self.provider = provider
	}
}

// MARK: - Extensions

// MARK: Mutation

extension HomeReactor {
	func mutate(action: Action) -> Observable<Mutation> {
		return .empty()
	}
}

// MARK: Reduce

extension HomeReactor {
	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state
		
		switch mutation {
			case .setMeta(let meta):
				newState.meta = meta
			case .setMovies(let movies):
				newState.movies = movies
			case .setError(let error):
				errorSubject.onNext(error)
		}
		
		return newState
	}
}

// MARK: Method

private extension HomeReactor {
	func fetchMovieResult() -> Observable<Mutation> {
		let fetchResult = provider.networkService.fetchMovies()
		
		switch fetchResult {
			case .success(let result):
				return .of(.setMeta(result.metaData), .setMovies(result.movie))
			case .failure(let error):
				return .just(.setError(error: error))
		}
	}
}
