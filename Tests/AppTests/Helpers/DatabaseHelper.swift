@testable import App
import Vapor

final class DatabaseHelper {

    // MARK: - ConditionDatabaseModel
    static func createCondition(app: Application, title: String) -> ConditionDatabaseModel {
        let model = ConditionDatabaseModel(title: title)
        try? model.save(on: app.db).wait()

        return model
    }

    // MARK: - ConditionRequirementDatabaseModel
    static func createConditionRequirement(app: Application, conditionId: UUID, requirementId: UUID) -> ConditionRequirementDatabaseModel {
        let model = ConditionRequirementDatabaseModel(conditionId: conditionId, requirementId: requirementId)
        try? model.save(on: app.db).wait()

        return model
    }

    // MARK: - ParameterConditionValueDatabaseModel
    static func createParameterConditionValue(app: Application, parameterId: UUID, conditionId: UUID, value: String) -> ParameterConditionValueDatabaseModel {
        let model = ParameterConditionValueDatabaseModel(parameterId: parameterId, conditionId: conditionId, value: value.data)
        try? model.save(on: app.db).wait()

        return model
    }

    static func createParameterConditionValue(app: Application, parameterId: UUID, conditionId: UUID, value: Int) -> ParameterConditionValueDatabaseModel {
        let model = ParameterConditionValueDatabaseModel(parameterId: parameterId, conditionId: conditionId, value: "\(value)".data)
        try? model.save(on: app.db).wait()

        return model
    }

    static func createParameterConditionValue(app: Application, parameterId: UUID, conditionId: UUID, value: Double) -> ParameterConditionValueDatabaseModel {
        let model = ParameterConditionValueDatabaseModel(parameterId: parameterId, conditionId: conditionId, value: "\(value)".data)
        try? model.save(on: app.db).wait()

        return model
    }

    static func createParameterConditionValue(app: Application, parameterId: UUID, conditionId: UUID, value: Bool) -> ParameterConditionValueDatabaseModel {
        let model = ParameterConditionValueDatabaseModel(parameterId: parameterId, conditionId: conditionId, value: "\(value)".data)
        try? model.save(on: app.db).wait()

        return model
    }


    // MARK: - ParameterDatabaseModel
    static func createParameter(app: Application, key: String = "key", description: String = "description", standard: String) -> ParameterDatabaseModel {
        let model = ParameterDatabaseModel(key: key, description: description, standard: standard.data)
        model.$conditions.value = []
        try? model.save(on: app.db).wait()

        return model
    }

    static func createParameter(app: Application, key: String = "key", description: String = "description", standard: Int) -> ParameterDatabaseModel {
        let model = ParameterDatabaseModel(key: key, description: description, standard: "\(standard)".data)
        try? model.save(on: app.db).wait()

        return model
    }

    static func createParameter(app: Application, key: String = "key", description: String = "description", standard: Double) -> ParameterDatabaseModel {
        let model = ParameterDatabaseModel(key: key, description: description, standard: "\(standard)".data)
        try? model.save(on: app.db).wait()

        return model
    }

    static func createParameter(app: Application, key: String = "key", description: String = "description", standard: Bool) -> ParameterDatabaseModel {
        let model = ParameterDatabaseModel(key: key, description: description, standard: "\(standard)".data)
        try? model.save(on: app.db).wait()

        return model
    }

    // MARK: - RequirementDatabaseModel
    static func createRequirement(app: Application, when: String, operator: String, then: String) -> RequirementDatabaseModel {
        let model = RequirementDatabaseModel(when: when, operator: `operator`, then: then)
        try? model.save(on: app.db).wait()

        return model
    }
}

fileprivate extension String {
    var data: Data {
        self.data(using: .utf8) ?? Data()
    }
}
