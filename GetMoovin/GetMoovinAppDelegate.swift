//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import FHIR
import FHIRToFirestoreAdapter
import FirebaseAccount
import FirebaseAuth
import class FirebaseFirestore.FirestoreSettings
import FirestoreDataStorage
import FirestoreStoragePrefixUserIdAdapter
import GetMoovinMockDataStorageProvider
import GetMoovinSchedule
import HealthKit
import HealthKitDataSource
import HealthKitToFHIRAdapter
import Questionnaires
import Scheduler
import SwiftUI


    
class GetMoovinAppDelegate: CardinalKitAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: FHIR()) {
            GetMoovinScheduler()
            FirebaseAccountConfiguration()
            firestore
            if HKHealthStore.isHealthDataAvailable() {
                healthKit
            }
            QuestionnaireDataSource()
            MockDataStorageProvider()
        }
    }
    
    
    //private var firestore: Firestore<FHIR> {
        //Firestore(
            //adapter: {
                //FHIRToFirestoreAdapter()
                //FirestoreStoragePrefixUserIdAdapter()
            //},
            //settings: .emulator
        //)
    //}
    
    
    // NEW VERSION STARTS HERE
    private var firestore: Firestore<FHIR> {
        var firestoreSettings = FirestoreSettings()
        let settings = FirestoreSettings()
        settings.host = "localhost:8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        
        return Firestore(
            adapter: {
                FHIRToFirestoreAdapter()
                FirestoreStoragePrefixUserIdAdapter()
            },
            settings: firestoreSettings
        )
    }
    // NEW VERSION ENDS HERE
    
    private var healthKit: HealthKit<FHIR> {
        HealthKit {
            CollectSample(
                HKQuantityType(.stepCount),
                deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
            )
        } adapter: {
            HealthKitToFHIRAdapter()
        }
    }
}
