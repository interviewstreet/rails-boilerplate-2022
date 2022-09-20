module PublicationHelper
  def get_user_blogs(user:)
    publications = PublicationBlogMapping
                    .includes(:blog)
                    .where(user: user) # First Query
    ordered_blog_ids = []
    blogs_hash = {}
    publications.each do |publication|
      blog = publication.blog # N Queries
      ordered_blog_ids << blog.id
      blogs_hash[blog.id.to_s] = {
        name: blog.name,
        content: blog.content
      }
    end
    return blogs_hash, ordered_blog_ids
  end

  def bulk_save_blogs(blogs:, emails:)
    users = User.where(email: emails) # First Query
    users_hash = {}
    users.each do |user|
      users_hash[user.email.to_s] = user
    end

    blogs.each do |blog|
      blog = Blog.new(
        name: blog[:name],
        content: blog[:content],
        user: users_hash[blog[:email].to_s]
      )
      blog.save! # N Queries
    end
  end
end