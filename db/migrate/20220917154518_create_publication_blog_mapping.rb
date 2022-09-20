class CreatePublicationBlogMapping < ActiveRecord::Migration[7.0]
  def change
    create_table :publication_blog_mappings do |t|
      t.belongs_to :user
      t.belongs_to :blog
      t.belongs_to :publication
      t.timestamps
    end
  end
end
