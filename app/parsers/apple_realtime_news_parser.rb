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

          # update popularity
          match = page.css('.urcc').text.match(/人氣\((?<popularity>\d+)\)/)
          news.popularity = match[:popularity].to_i if !!match

          # parse author
          parse_author(news)
        end
        news.save!
      end
    end

    def parse_author(news)
      if news.content && news.author.nil?
        content = news.content.gsub(/<br(\s*\/)?>/, '')
        scan_datas = content.reverse.scan(/[）|)](?<author>.*?)[\/|／|╱](?<report_type>.*?)[(|（]/)
        if scan_datas.count > 0
          news.author = scan_datas.first[1].reverse
          news.report_type = scan_datas.first[0].reverse

          news.author.strip! if news.author
          news.report_type.strip! if news.report_type

          news.author = nil if news.author.length > 20
          news.report_type = nil if news.report_type.length > 20
        end
      end
    end

    def update_popularity(news)
      page = Nokogiri::HTML(RestClient.get news.url)
      match = page.css('.urcc').text.match(/人氣\((?<popularity>\d+)\)/)
      news.popularity = match[:popularity].to_i if !!match
      news.save!
    end
  end
end
