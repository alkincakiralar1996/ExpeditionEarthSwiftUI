// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeletePlanetMutation: GraphQLMutation {
  public static let operationName: String = "deletePlanet"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation deletePlanet($id: String!) {
        deletePlanet(id: $id)
      }
      """#
    ))

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: ExpeditionEarthAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { ExpeditionEarthAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deletePlanet", Bool.self, arguments: ["id": .variable("id")]),
    ] }

    public var deletePlanet: Bool { __data["deletePlanet"] }
  }
}
