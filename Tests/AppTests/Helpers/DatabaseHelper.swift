@testable import App
import Vapor

final class DatabaseHelper {
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
}

fileprivate extension String {
    var data: Data {
        self.data(using: .utf8) ?? Data()
    }
}
