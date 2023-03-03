// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct FragmentPlanet: ExpeditionEarthAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString { """
    fragment fragmentPlanet on Planet {
      __typename
      id
      name
      oxygen
      distance
      lightYears
      mAh
      image
    }
    """ }

  public let __data: DataDict
  public init(data: DataDict) { __data = data }

  public static var __parentType: ApolloAPI.ParentType { ExpeditionEarthAPI.Objects.Planet }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("id", String?.self),
    .field("name", String?.self),
    .field("oxygen", Double?.self),
    .field("distance", Int?.self),
    .field("lightYears", Double?.self),
    .field("mAh", Double?.self),
    .field("image", String?.self),
  ] }

  public var id: String? { __data["id"] }
  public var name: String? { __data["name"] }
  public var oxygen: Double? { __data["oxygen"] }
  public var distance: Int? { __data["distance"] }
  public var lightYears: Double? { __data["lightYears"] }
  public var mAh: Double? { __data["mAh"] }
  public var image: String? { __data["image"] }
}
