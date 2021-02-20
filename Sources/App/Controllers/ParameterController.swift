import Vapor
import Fluent
import VlaggenNetworkModels

struct ParameterController {

    private let service: ParameterServiceLogic

    init(service: ParameterServiceLogic = ParameterService()) {
        self.service = service
    }

    // TODO: Certainly needs way more testing
    func all(req: Request) throws -> EventLoopFuture<[ParameterResponse]> {
        return try service.list(db: req.db)
            .map { (parameters) -> ([ParameterDatabaseModel]) in

                // Parameters
                parameters.forEach { (parameter) in
                    req.logger.info("Parameter: \(parameter.key)")

                    // Conditions
                    let conditions = parameter.conditions.sorted(by: {
                        return $0.requirements.count > $1.requirements.count
                    })

                    for condition in conditions {
                        req.logger.info(" - Condition: \(condition.title)")

                        // Requirements
                        condition.requirements.forEach { (requirement) in
                            req.logger.info("   - Requirement: \(requirement.when) \(requirement.operator) \(requirement.then)")
                        }

                        // Go through all the requirements of the condition and see if they match with all the requirements
                        let matchingRequirements = condition.requirements
                            .match { (requirement) -> Bool in

                                guard let `operator` = Operator(rawValue: requirement.operator) else {
                                    req.logger.error("Operator is not supported \(requirement.operator)")
                                    return false
                                }

                                if let value = req.query[Bool.self, at: requirement.when],
                                   let valueThen = Bool(requirement.then) {
                                    return Comparator.compare(lhs: value, operator: `operator`, rhs: valueThen)
                                }

                                if let value = req.query[Double.self, at: requirement.when],
                                   let valueThen = Double(requirement.then) {
                                    return Comparator.compare(lhs: value, operator: `operator`, rhs: valueThen)
                                }

                                if let value = req.query[String.self, at: requirement.when] {
                                    return Comparator.compare(lhs: value, operator: `operator`, rhs: requirement.then)
                                }

                                return false
                            }

                        // When it matches all the requirements the correct value should be found
                        if matchingRequirements {
                            let conditionValue = parameter.conditionValues.first(where: { $0.conditionId == condition.id })
                            if let value = conditionValue?.value {
                                // Set the conditional value as 'standard' to override the standard parameter value
                                parameter.standard = value
                                break // Return the forEach of going through the `parameter.conditions`.
                            }
                        }
                    }

                    req.logger.info("Value: \(String(data: parameter.standard, encoding: .utf8) ?? "unknown")")
                }

                return parameters
            }
            .mapEachCompact { $0.mapToParameterResponse }
    }

    func routes(routes: RoutesBuilder) {
        // All
        routes.get(use: self.all)
    }
}

extension Collection {
    public func match(includeElement: (Self.Element) -> Bool) -> Bool {
        if isEmpty {
            return false
        }

        for element in self {
            if !includeElement(element) {
                return false
            }
        }

        return true
    }
}
