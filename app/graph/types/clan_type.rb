ClanType = GraphQL::ObjectType.define do
  name 'Clan'
  description 'The clan object'

  field :id, !types.ID
  field :name, !types.String
  field :quests, types[QuestType]
end
