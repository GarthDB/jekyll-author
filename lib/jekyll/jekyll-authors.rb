require "fileutils"

module Jekyll
  class JekyllAuthors < Jekyll::Generator
    # safe true
    priority :lowest

    # Main plugin action, called by Jekyll-core
    def generate(site)
      @site = site
    end

    # private
  end
end
