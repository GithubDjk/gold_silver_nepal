# frozen_string_literal: true

require_relative "gold_silver_nepal/version"
require "nokogiri"
require "open-uri"

module GoldSilverNepal
  # scrapper for gold silver rate
  class Scraper
    GOLD_SILVER_URL = "https://www.fenegosida.org/"

    def self.scrape
      html = URI.open(GOLD_SILVER_URL)
      @doc = Nokogiri::HTML(html)

      fine_gold_gram = @doc.css('div.rate-gold p:contains("FINE GOLD (9999)") b')[0]&.text&.strip&.to_i
      fine_gold_tola = @doc.css('div.rate-gold p:contains("FINE GOLD (9999)") b')[1]&.text&.strip&.to_i

      tejabi_gold_gram = @doc.css('div.rate-gold p:contains("TEJABI GOLD") b')[0]&.text&.strip&.to_i
      tejabi_gold_tola = @doc.css('div.rate-gold p:contains("TEJABI GOLD") b')[1]&.text&.strip&.to_i

      silver_gram = @doc.css('div.rate-silver p:contains("SILVER") b')[0]&.text&.strip&.to_i
      silver_tola = @doc.css('div.rate-silver p:contains("SILVER") b')[1]&.text&.strip&.to_i

      @params = {
        "fine_gold_gram" => fine_gold_gram,
        "fine_gold_tola" => fine_gold_tola,
        "tejabi_gold_gram" => tejabi_gold_gram,
        "tejabi_gold_tola" => tejabi_gold_tola,
        "silver_gram" => silver_gram,
        "silver_tola" => silver_tola
      }

      @params
    rescue StandardError => error
      puts "An error occurred: #{error.message}"
    end
  end
end
