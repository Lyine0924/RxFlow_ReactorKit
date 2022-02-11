//
//  SampleStep.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import RxFlow

enum SampleStep: Step {
	// Global
	case alert(message: String)
	case dismiss
	
	// Login
	case loginIsRequired
	case loginIsCompleted
	
	// Main
	case mainTabBarIsRequired
	
	// Home
	case homeIsRequired
	case homeItemIsPicked(withID: String)
	
	// Middle
	case middleIsRequired
	case middleIsRequiredAgain
	case middleDetailIsRequired
	
	// Setting
	case settingIsRequired
	case settingAndAlertIsRequired(message: String)
}
