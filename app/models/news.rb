class News < ActiveRecord::Base
  before_save :save_author

  default_scope { order(created_at: :desc) }
  scope :shiyijei, -> { where(author: "施旖婕") }

  def save_author
    if !self.content.nil? && self.author.nil?
      match_data = self.content.match(/[(|（](?<author>.+)[\/|／|╱](?<report_type>.+)[）|)]/)
      if !!match_data
        self.author = match_data[:author]
        self.report_type = match_data[:report_type]

        self.author.strip! if self.author
        self.report_type.strip! if self.report_type

        self.author = nil if self.author.length > 20
        self.report_type = nil if self.report_type.length > 20
      end
    end
  end
end
