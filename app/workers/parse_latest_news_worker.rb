class ParseLatestNewsWorker
  include Sidekiq::Worker
  def perform
    6.times {|i| AppleRealtimeNewsParser.parse_article_list(6-i) }
  end
end
