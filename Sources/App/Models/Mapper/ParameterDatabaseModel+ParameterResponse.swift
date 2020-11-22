import Foundation
import VlaggenNetworkModels

extension ParameterDatabaseModel {

    var mapToParameterResponse: ParameterResponse? {
        if let value = try? ParameterValue(data: standard) {
            return ParameterResponse(key: key, value: value)
        }

        return nil
    }
}
