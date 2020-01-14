class MeSerializer < ActiveModel::Serializer
  attributes :id,
              :name,
              :bio,
              :token,
              :email,
              :created_at,
              :update_at
end
