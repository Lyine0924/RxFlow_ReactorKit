//
//  SceneDelegate.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit
import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	
	private let coordinator: FlowCoordinator = .init()
	private let disposeBag: DisposeBag = .init()


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }
    
    registerProviderFactories()
		
		coordinatorLogStart()
		
		// App Initialize
		
		coordinateToAppFlow(with: windowScene)
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}


}

// MARK: Coordinator Extension

extension SceneDelegate {
	private func coordinateToAppFlow(with windowScene: UIWindowScene) {
		let window = UIWindow(windowScene: windowScene)
		
		let rootComponent = RootComponent(window: window)
		
    coordinator.coordinate(flow: rootComponent.appFlowBuilder.flow, with: rootComponent.appFlowBuilder.stepper)
		
		window.makeKeyAndVisible()
    
    self.window = window
	}
	
	private func coordinatorLogStart() {
		coordinator.rx.willNavigate
			.subscribe(onNext: { flow, step in
				let currentFlow = "\(flow)".split(separator: ".").last ?? "no flow"
				print("➡️ will navigate to flow = \(currentFlow) and step = \(step)")
			})
			.disposed(by: disposeBag)
		
		// didNavigate
	}
}
