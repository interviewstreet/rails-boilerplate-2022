class PublicationBlogMapping < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  belongs_to :publication
end