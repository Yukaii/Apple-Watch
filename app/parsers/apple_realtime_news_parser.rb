require 'nokogiri'
require 'rest-client'
require 'httpclient'
require 'uri'
require 'thread'
require 'thwait'

module AppleRealtimeNewsParser
  class << self
    def http_client
      @clnt ||= HTTPClient.new
    end

    def parse_article_list(page_count = 1)
      base_url = "http://www.appledaily.com.tw"
      begin
        page = Nokogiri::HTML(http_client.get_content "http://www.appledaily.com.tw/realtimenews/section/new/#{page_count}")
      rescue Exception => e
        puts e
        return
      end

      # deal with cross-day condition
      dates = page.css('h1.dddd time').map(&:text)

      page.css('ul.rtddd').each_with_index do |article_table, i|
        article_urls = article_table.css('li a').map {|d| "#{base_url}#{URI.encode(d[:href])}" }
        times = article_table.css('li time').map(&:text)
        parse_article_urls(article_urls, dates[i], times)
      end
    end

    def parse_article_urls(article_urls, date, times)
      article_urls.each_with_index do |article_url, index|
        article = Article.find_or_initialize_by(url: article_url)
        if article.content.nil? || article.title.nil?
          # parse page and save content
          begin
            page = Nokogiri::HTML(http_client.get_content article.url)

            # parse summary
            summary = page.css("#summary")
            summary.search('br').each {|d| d.replace("\n")}

            other_contents = page.xpath('//p[@id="summary"]/following-sibling::text()')
            other_contents.search('br').each {|d| d.replace("\n")}

            article.summary = summary.text.gsub(/\n/, "<br/>")
            article.content = article.summary + other_contents.map(&:text).join("\n\n").strip.gsub(/\n/, "<br/>")

            # parse title
            article.title = page.css('#h1').text
            # published date
            article.published_at = DateTime.strptime("#{date} #{times[index]} +8", "%Y / %m / %d %H:%M %z")

            # update popularity
            match = page.css('.urcc').text.match(/人氣\((?<popularity>\d+)\)/)
            article.popularity = match[:popularity].to_i if !!match

            # parse author
            parse_author(article)

            # parse image
            images = page.css('.lbimg img')
            article.image_url = images.first[:src] if not images.empty?
          rescue Exception => e

          end
        end
        article.save!
      end
    end

    def parse_author(article)
      if article.content && article.author.nil?
        content = article.content.gsub(/<br(\s*\/)?>/, '')
        scan_datas = content.reverse.scan(/[）|)](?<author>.*?)[\/|／|╱](?<report_type>.*?)[(|（]/)
        if scan_datas.count > 0
          article.author = scan_datas.first[1].reverse
          article.report_type = scan_datas.first[0].reverse

          article.author.strip! if article.author
          article.report_type.strip! if article.report_type

          article.author = nil if article.author.length > 20
          article.report_type = nil if article.report_type.length > 20
        end
      end
    end

    def update_popularity(article)
      page = Nokogiri::HTML(http_client.get_content article.url)
      match = page.css('.urcc').text.match(/人氣\((?<popularity>\d+)\)/)
      article.popularity = match[:popularity].to_i if !!match
      article.save!
    end
  end
end
