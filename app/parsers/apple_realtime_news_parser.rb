require 'nokogiri'
require 'rest-client'
require 'uri'

module AppleRealtimeNewsParser
  class << self
    def parse_news_list(page_count = 1)
      base_url = "http://www.appledaily.com.tw"
      page = Nokogiri::HTML(RestClient.get "http://www.appledaily.com.tw/realtimenews/section/new/#{page_count}")

      # deal with cross-day condition
      dates = page.css('h1.dddd time').map(&:text)

      page.css('ul.rtddd').each_with_index do |news_table, i|
        news_urls = news_table.css('li a').map {|d| "#{base_url}#{URI.encode(d[:href])}" }
        times = news_table.css('li time').map(&:text)
        parse_news_urls(news_urls, dates[i], times)
      end
    end

    def parse_news_urls(news_urls, date, times)
      news_urls.each_with_index do |news_url, index|
        news = News.find_or_create_by(url: news_url)
        if news.content.nil? || news.title.nil?
          # parse page and save content
          page = Nokogiri::HTML(RestClient.get news.url)

          # parse summary
          summary = page.css("#summary")
          summary.search('br').each {|d| d.replace("\n")}
          news.content = summary.text.gsub(/\n/, "<br/>")
          # news.content = summary.to_html.html_safe

          # parse title
          news.title = page.css('#h1').text
          # published date
          news.published_at = DateTime.strptime("#{date} #{times[index]}", "%Y / %m / %d %H:%M")

        end
        news.save!
      end
    end
  end
end
