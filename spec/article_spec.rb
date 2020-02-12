require "rspec"
require "spec_helper"
require_relative "../config/environment.rb"

RSpec.describe Article do
  article = Article.new("title", "description", "url")
  describe "#initialize" do
    it "initiializes with a title, description and url" do
      expect(article.title).to eq "title"
      expect(article.description).to eq "description"
      expect(article.url).to eq "url"
    end
  end

  describe ".destroy_all" do
    it "removes all objects from the @@all class variable" do
      Article.destroy_all
      expect(Article.all.size).to eq 0
    end
  end

  describe ".all" do
    it "objects are added to @@all when instantiated" do
      Article.destroy_all
      article = Article.new("title", "description", "url")
      expect(Article.all.size).to eq 1
      article_two = Article.new("title", "desc", "url")
      expect(Article.all.size).to eq 2
    end
  end
end
