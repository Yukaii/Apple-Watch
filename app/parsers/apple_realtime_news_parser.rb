require 'nokogiri'
require 'rest-client'
require 'uri'

module AppleRealtimeNewsParser
  class << self
    def parse_news_list(page_count = 1)
      base_url = "http://www.appledaily.com.tw"
      page = Nokogiri::HTML(RestClient.get "http://www.appledaily.com.tw/realtimenews/section/new/#{page_count}")
      news_urls = page.css('.rtddd li a').map {|d| "#{base_url}#{URI.encode(d[:href])}"}
      news_urls.each do |news_url|
        news = News.find_or_create_by(url: news_url)
        if news.content.nil? || news.title.nil?
          # parse and save content
          page = Nokogiri::HTML(RestClient.get news.url)

          summary = page.css("#summary")
          summary.search('br').each {|d| d.replace("\n")}
          news.content = summary.text.gsub(/\n/, "<br/>")
          # news.content = summary.to_html.html_safe

          news.title = page.css('#h1').text

          news.save!
        end
      end
    end
  end
end
