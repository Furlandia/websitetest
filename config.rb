require 'active_support/core_ext/array/grouping'

Time.zone = 'Pacific Time (US & Canada)'
FIRST_YEAR = '2013'
CURRENT_YEAR = '2017'
ARTICLE_CUTOFF = 2000

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'
set :markdown_engine, :kramdown
set :markdown, parse_block_html: true
set :haml, { attr_wrapper: '"' }

page '*', layout: 'panel'
page '/posts/*', layout: 'post'
page 'index.html', layout: 'default'
page 'schedule.html', layout: 'wide'
page 'mature-events.json', layout: nil
page 'schedule.ics', layout: nil

activate :livereload
activate :middleman_simple_thumbnailer

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
  set :http_prefix, "/#{CURRENT_YEAR}"
end

activate :blog do |blog|
  blog.prefix = 'posts'
  blog.permalink = '{year}-{month}-{day}-{title}.html'
  blog.default_extension = '.md'
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-27731627-8'
end

%w(*.swp *.swo .*.swp .*.swo).each{|file| ignore file}

helpers do
  def current_year
    CURRENT_YEAR
  end

  def past_years
    (FIRST_YEAR.to_i...CURRENT_YEAR.to_i).to_a
  end

  def article_cutoff
    ARTICLE_CUTOFF
  end

  def markdown(source)
    return '' unless source
    Tilt::KramdownTemplate.new{source.strip}.render
  end

  def friendly_linebreaks(str, char)
    str.gsub(/([^#{char}])\s/, '\1&nbsp;')
  end

  def map_link(address)
    "https://www.google.com/maps/search/#{address.gsub(' ', '+')}+Portland+Oregon"
  end

  def each_social_link(links)
    links.each do |site, name|
      site = site[/[a-z]+/,0]
      url = case site
      when 'deviantart'
        "https://#{name}.deviantart.com/"
      when 'facebook'
        "https://www.facebook.com/#{name}"
      when 'furaffinity'
        "https://www.furaffinity.net/user/#{name}/"
      when 'instagram'
        "https://www.instagram.com/#{name}"
      when 'pinterest'
        "https://www.pinterest.com/#{name}"
      when 'tumblr'
        "http://#{name}.tumblr.com"
      when 'twitter'
        "https://twitter.com/#{name}"
      when 'vine'
        "https://vine.co/#{name}"
      when 'weasyl'
        "https://www.weasyl.com/user/#{name}"
      when 'youtube'
        "https://www.youtube.com/user/#{name}"
      when 'etsy'
        "https://www.etsy.com/shop/#{name}"
      when 'deviantart'
        "https://#{name}.deviantart.com/"
      # when 'inkbunny'
      #   "https://inkbunny.net/#{name}"
      when 'pinterest'
        "https://www.pinterest.com/#{name}"
      # when 'patreon'
      #   "https://www.patreon.com/#{name}"
      when 'website'
        name
      else
        next
      end

      yield site, url
    end
  end

  def get_event_class(event)
    if event[:name] == 'Closed'
      'event-closed'
    elsif event[:mature]
      'event-mature'
    else
      'event-open'
    end
  end

  def event_id(event)
    "event-#{Digest::MD5.hexdigest(event.to_json)}"
  end

  def get_events_at(day, time)
    data.schedule.map do |room, days|
      events = days[day] || []
      found = events.select{|e| e[:start] == time}
      raise "Multiple events start at #{time} #{day} in #{room}" if found.size > 1
      found.first
    end
  end
end
