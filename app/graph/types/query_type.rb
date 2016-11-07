# app/graph/types/query_type.rb
QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :user do
    type UserType
    argument :user_id, types.ID
    resolve -> (_, args, ctx) {
      if args.key? :user_id
        User.find(args[:user_id])
      else
        ctx[:current_user]
      end
    }
  end

  field :clan do
    type ClanType
    argument :clan_id, types.ID
    resolve -> (_, args, ctx) {
      if args.key? :clan_id
        Clan.find(args[:clan_id])
      else
        ctx[:current_user]&.clan
      end
    }
  end
end
