QuestType = GraphQL::ObjectType.define do
  name 'Quest'
  description 'The qust type'

  field :name, !types.String
  field :description, !types.String
  field :status, !types.String
end
