class Site < Sinatra::Base
  before do
    ENV['RACK_ENV'] ||= 'development'
    referer = ENV['RACK_ENV']
    end
    @query = EightyeightpagesClient::Query.new 'kinesis', referer
    @navigation_links = @query.navigation_links.order_by(cms_position: 'asc')
  end

  helpers do
    def links_from_know_more(text)
      doc = Nokogiri::XML text
      doc.xpath "//a"
    end
  end

  get "/stylesheets/:file.css" do |file|
    content_type 'text/css'
    sass(:"stylesheets/#{file}", :load_paths => ([ File.join(File.dirname(__FILE__), 'views', 'stylesheets') ]))
  end

  get '/' do
    @page = @query.pages.where(handle: 'home').first
    haml :index
  end
