UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'The user object'

  field :first_name, types.String
  field :last_name, types.String
  field :hero_name, types.String
  field :email, types.String

  field :quests, types[QuestType] do
    argument :status, types.String
    resolve -> (obj, args, ctx) {
      if args.key?('status')
        Quest.where(user: obj, status: args['status']).all
      else
        obj.quests
      end
    }
  end

  field :clan do
    type ClanType
  end
end
