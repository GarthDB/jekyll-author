module Jekyll
  class Authors
    class << self
      def authors?(site)
        (site.data.key?('authors') || site.config.key?('authors'))
      end

      def merge_authors(site)
        site.config['authors'].merge!(site.data['authors']) { |_key, v1, _v2| v1 }
      end

      def default_author?(site)
        (site.config.key?('author'))
      end

      def set_default(site)
        site.config['author'] = site.config['authors'].values[0]
      end

      def post_author?(post)
        (post.author.is_a?(String) && post.site.config['authors'].key?(post.author))
      end

      def attach_author(post)
        post.data['author'] = post.site.config['authors'][post.author]
      end
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  Jekyll::Authors.merge_authors(site) if Jekyll::Authors.authors?(site)
  Jekyll::Authors.set_default(site) if !Jekyll::Authors.default_author?(site) && Jekyll::Authors.authors?(site)
end

Jekyll::Hooks.register :posts, :pre_render do |post|
  Jekyll::Authors.attach_author(post) if Jekyll::Authors.post_author?(post)
end
