module FacebookClient
  class << self
    # note that our page Access token NEVER expires
    # so this method only for demo how get access token
    def get_page_access_token(page_id: nil)
      result = HTTPClient.new.get_content "https://graph.facebook.com/v2.3/me/accounts?access_token=#{ENV['FB_ACCESS_TOKEN']}";

      json_data = JSON.parse(result.body)
      page = json_data["data"].find {|d| d["id"] == (page_id || ENV['FB_PAGE_ID'])}
      if not page.nil?
        @page_access_token ||= page["access_token"]
      else
        nil
      end
    end
  end
end
