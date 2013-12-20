class SmallWorker
  include Sidekiq::Worker
  def perform(id)
    sleep 3
    post = Post.find(id)
    name = "<strong>#{post.name}</strong>"
    post.update_attribute(:name, name)
  end
end