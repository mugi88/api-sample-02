class UserSerializer < ActiveModel::Serializer
  attributes :id,
              :name,
              :bio,
              :created_at,
              :update_at
end
