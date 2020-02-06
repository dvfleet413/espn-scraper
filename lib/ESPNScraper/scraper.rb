class Scraper

  def self.scrape_new_articles(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    stories = doc.css("div.item-info-wrap")
    # title stories.css("h1").text
    # description stories.css("p").text
    stories.each do |story|
      title = story.css("h1").text
      description = story.css("p").text
      url = "https://www.espn.com#{story.css("a").attribute("href").value}"
      Article.new(title, description, url)
    end
  end

  def self.get_content(article)
    html = open(article.url)
    doc = Nokogiri::HTML(html)
    article.content = doc.css("div.article-body p")
  end

end
