// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct GameCenterMatchmakingRuleSetResponse: Codable {
	/// GameCenterMatchmakingRuleSet
	public var data: GameCenterMatchmakingRuleSet
	public var included: [IncludedItem]?
	public var links: DocumentLinks

	public enum IncludedItem: Codable {
		case gameCenterMatchmakingTeam(GameCenterMatchmakingTeam)
		case gameCenterMatchmakingRule(GameCenterMatchmakingRule)
		case gameCenterMatchmakingQueue(GameCenterMatchmakingQueue)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(GameCenterMatchmakingTeam.self) {
				self = .gameCenterMatchmakingTeam(value)
			} else if let value = try? container.decode(GameCenterMatchmakingRule.self) {
				self = .gameCenterMatchmakingRule(value)
			} else if let value = try? container.decode(GameCenterMatchmakingQueue.self) {
				self = .gameCenterMatchmakingQueue(value)
			} else {
				throw DecodingError.dataCorruptedError(
					in: container,
					debugDescription: "Data could not be decoded as any of the expected types (GameCenterMatchmakingTeam, GameCenterMatchmakingRule, GameCenterMatchmakingQueue)."
				)
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .gameCenterMatchmakingTeam(let value): try container.encode(value)
			case .gameCenterMatchmakingRule(let value): try container.encode(value)
			case .gameCenterMatchmakingQueue(let value): try container.encode(value)
			}
		}
	}

	public init(data: GameCenterMatchmakingRuleSet, included: [IncludedItem]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: StringCodingKey.self)
		self.data = try values.decode(GameCenterMatchmakingRuleSet.self, forKey: "data")
		self.included = try values.decodeIfPresent([IncludedItem].self, forKey: "included")
		self.links = try values.decode(DocumentLinks.self, forKey: "links")
	}

	public func encode(to encoder: Encoder) throws {
		var values = encoder.container(keyedBy: StringCodingKey.self)
		try values.encode(data, forKey: "data")
		try values.encodeIfPresent(included, forKey: "included")
		try values.encode(links, forKey: "links")
	}
}
