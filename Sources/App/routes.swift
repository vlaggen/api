import Fluent
import Vapor

func routes(_ app: Application) throws {
    let api = app.routes.grouped("api")
    let v1 = api.grouped("v1")

    let parameterController = ParameterController()
    let parameters = v1.grouped("parameters")
    parameterController.routes(routes: parameters)
    
}
