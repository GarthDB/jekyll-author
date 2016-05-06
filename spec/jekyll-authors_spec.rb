require 'spec_helper'

describe(Jekyll::Authors) do
  let(:overrides) { Hash.new }
  let(:config) do
    Jekyll.configuration(Jekyll::Utils.deep_merge_hashes({
      "full_rebuild" => true,
      "source"      => source_dir,
      "destination" => dest_dir,
      "show_drafts" => true,
      "url"         => "http://example.org",
      "name"       => "My awesome site",
      "author"      => {
        "name"        => "Dr. Jekyll"
      },
      "collections" => {
        "my_collection" => { "output" => true },
        "other_things"  => { "output" => false }
      }
    }, overrides))
  end
  let(:site)     { Jekyll::Site.new(config) }
  let(:generated_page) { File.read(dest_dir("2013/12/12/dec-the-second.html")) }
  let(:context)  { make_context(site: site) }
  before(:each) do
    site.process
  end

  it "has authors from _config.yml" do
    expect(site.authors['garthdb']['name']).to match(/\AGarth Braithwaite/)
  end

  it "has authors from _data/authors.yml" do
    expect(site.authors['pathawks']['name']).to match(/\APat Hawks/)
  end

  it "prioritizes _config.yml data" do
    expect(site.authors['benbalter']['name']).to match('Ben Balter')
  end

  it "uses authors data for page author" do
    expect(generated_page).to match(/Garth Braithwaite/)
  end

end
