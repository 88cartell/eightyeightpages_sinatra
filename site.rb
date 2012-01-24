class Site < Sinatra::Base
  before do
    @query = EightyeightpagesClient::Query.new 'YOUR SITE HERE', 'localhost'
  end

  get "/stylesheets/:file.css" do |file|
    content_type 'text/css'
    sass(:"stylesheets/#{file}", :load_paths => ([ File.join(File.dirname(__FILE__), 'views', 'stylesheets') ]))
  end

  get '/' do
    # Uncomment this line to load the home page.
    # @page = @query.pages.where(handle: 'home').first
    haml :page
  end
end
