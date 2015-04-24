class News < ActiveRecord::Base
  before_save :save_author

  default_scope { order(created_at: :desc) }
  scope :shiyijei, -> { where(author: "施旖婕") }

  def save_author
    if self.content && self.author.nil?
      content = self.content.gsub(/<br(\s*\/)?>/, '')
      scan_datas = content.reverse.scan(/[）|)](?<author>.*?)[\/|／|╱](?<report_type>.*?)[(|（]/)
      if scan_datas.count > 0
        self.author = scan_datas.first[1].reverse
        self.report_type = scan_datas.first[0].reverse

        self.author.strip! if self.author
        self.report_type.strip! if self.report_type

        self.author = nil if self.author.length > 20
        self.report_type = nil if self.report_type.length > 20
      end
    end
  end

  def update_popularity(page)
    match = page.css('.urcc').text.match(/人氣\((?<popularity>\d+)\)/)
    self.popularity = match[:popularity].to_i if !!match
  end

  def load_page
    if self.url
      return Nokogiri::HTML(RestClient.get self.url)
    end
    nil
  end
end
