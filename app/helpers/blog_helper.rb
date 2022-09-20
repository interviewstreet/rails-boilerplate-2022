module BlogHelper
  def get_user_blogs(user:)
    blogs = Blog.where(user: user)
    blogs_hash = {}
    blogs.each do |blog|
      blogs_hash[blog.id.to_s] = {
        name: blog.name,
        content: blog.content
      }
    end
    ordered_blog_ids = blogs.pluck(:id)
    return blogs_hash, ordered_blog_ids
  end
end