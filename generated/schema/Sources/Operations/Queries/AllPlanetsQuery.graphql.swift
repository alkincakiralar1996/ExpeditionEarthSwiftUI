// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AllPlanetsQuery: GraphQLQuery {
  public static let operationName: String = "allPlanets"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query allPlanets {
        planets {
          __typename
          ...fragmentPlanet
        }
      }
      """#,
      fragments: [FragmentPlanet.self]
    ))

  public init() {}

  public struct Data: ExpeditionEarthAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { ExpeditionEarthAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("planets", [Planet?]?.self),
    ] }

    public var planets: [Planet?]? { __data["planets"] }

    /// Planet
    ///
    /// Parent Type: `Planet`
    public struct Planet: ExpeditionEarthAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { ExpeditionEarthAPI.Objects.Planet }
      public static var __selections: [ApolloAPI.Selection] { [
        .fragment(FragmentPlanet.self),
      ] }

      public var id: String? { __data["id"] }
      public var name: String? { __data["name"] }
      public var oxygen: Double? { __data["oxygen"] }
      public var distance: Int? { __data["distance"] }
      public var lightYears: Double? { __data["lightYears"] }
      public var mAh: Double? { __data["mAh"] }
      public var image: String? { __data["image"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public var fragmentPlanet: FragmentPlanet { _toFragment() }
      }
    }
  }
}
