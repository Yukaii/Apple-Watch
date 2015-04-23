## config/initializers/pry.rb
## encoding: utf-8
## 預設的 prompt_name 是 pry，下面這行會把 prompt_name 變成該 project 的名稱 (自動抓)
Pry.config.prompt_name = Rails.application.class.parent_name.underscore.dasherize

unless Rails.env.development?
  old_prompt = Pry.config.prompt

  if Rails.env.production?
    # 這邊本來應該是 Pry::Helpers::Text.red(Rails.env.upcase)
    #   相當於 "\e[0;31m#{Rails.env.upcase}\e[0m"
    #   但因為一個 readline 引起的 bug 導致輸入游標錯位，因此需加上 \001 \002 來跳過此問題，下同
    #   此問題的討論串在 https://github.com/pry/pry/issues/493
    env = "\001\e[0;31m\002#{Rails.env.upcase}\001\e[0m\002" # 紅色 的 env 名稱
  else
    env = "\001\e[0;33m\002#{Rails.env.upcase}\001\e[0m\002" # 黃色 的 env 名稱
  end

    # 替換 pry prompt 的方法在 https://github.com/pry/pry/wiki/Customization-and-configuration#Config_prompt 有教學
  Pry.config.prompt = [
    proc { |*a| "#{env} #{old_prompt.first.call(*a)}"  },
    proc { |*a| "#{env} #{old_prompt.second.call(*a)}" }
  ]
end
