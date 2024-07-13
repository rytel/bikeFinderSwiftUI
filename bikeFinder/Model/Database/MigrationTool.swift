////
////  MigrationTool.swift
////  bikeFinder
////
////  Created by Rafał Rytel on 11/07/2024.
////

import SwiftData

enum schemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        []
    }
    
    //paste old models
}

enum schemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        []
    }
    
    //paste new models
}

enum StationMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [schemaV1.self, schemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    //there is also .lightweight(..) migration, read the link above
    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: schemaV1.self, toVersion: schemaV2.self)
}
