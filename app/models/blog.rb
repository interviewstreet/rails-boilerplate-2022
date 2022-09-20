class Blog < ApplicationRecord
  belongs_to :user

  def get_keyword_frequency
    keywords = content["keywords"].map {|keyword| keyword.downcase}
    body = content["body"].downcase

    keywords_found = {}
    keywords.each do |keyword|
      keywords_found[keyword.to_s] = 0 if keywords_found[keyword.to_s].nil?
      if body.include?(keyword)
        keywords_found[keyword.to_s] += 1
      end
    end
    return keywords_found
  end
end
