class Scraper

  def self.scrape_new_articles(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    stories = doc.css("div.item-info-wrap")
    stories.each do |story|
      title = story.css("h1").text
      description = story.css("p").text
      if story.css("a").attribute("href").value.start_with?("http")
        url = story.css("a").attribute("href").value
      else
        url = "https://www.espn.com#{story.css("a").attribute("href").value}"
      end
      Article.new(title, description, url)
    end
  end

  def self.get_content(article)
    html = open(article.url)
    doc = Nokogiri::HTML(html)
    #for ESPN Radio links, this will return an empty array
    article.content = doc.css("div.article-body p")
  end

end
