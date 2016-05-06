module Jekyll
  class Authors
    class << self
      def authors?(site)
        (site.data.key?('authors') || site.config.key?('authors'))
      end

      def merge_authors(site)
        def site.authors
          Jekyll::Utils.deep_merge_hashes(data['authors'], config['authors'])
        end
      end

      def post_author?(post)
        (post.author.is_a?(String) && post.site.authors.key?(post.author))
      end

      def attach_author(post)
        post.data['author'] = post.site.authors[post.author]
        # puts post.author
      end
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  Jekyll::Authors.merge_authors(site) if Jekyll::Authors.authors?(site)
end

Jekyll::Hooks.register :posts, :pre_render do |post|
  Jekyll::Authors.attach_author(post) if Jekyll::Authors.post_author?(post)
  # puts post.author
end
