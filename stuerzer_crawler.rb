require_relative 'capybara_with_poltergeist'
require_relative 'support'
 
class StuerzerCrawler
  include CapybaraWithPoltergeist
  include Support

  def scrape_page
    new_session

    visit '/'

    ## Getting urls for sub menu in array ##
    anchor_xpath = "/html/body/div[1]/div/aside/div/nav/ul/li[1]/ul/li/a"
    sub_menus = get_array_for(anchor_xpath)

    ## Iterating over sub menus ##
    sub_menus.each do |new_page|
      visit new_page[:href]

      ## Header for page here ##
      puts page.find("/html/body/div[1]/div/section/div[1]/article/section[3]/h1").text

      ## Logic for extracting detail ##
      item_list_xpath = "/html/body/div[1]/div/section/div[1]/article/section[3]/div"
      item_list = get_array_for(item_list_xpath)

      item_list.each do |listed_item|
        record = []
        if listed_item.has_xpath?('div[1]/img')

          ## Removing un-necessary data and properly format data##
          listed_text = listed_item.text.gsub(" Detailsightsubmit request", "")

          ## Special cases, change as per site ##
          listed_text = listed_text.gsub(": :", ":")
          listed_text = listed_text.gsub(" :", ":")
          listed_text = listed_text.gsub("km - h", "km-h")

          ## Creating array of data, removing blank string, stripe string ##
          record = listed_text.split(/([a-z\d_-]+):/).collect(&:strip).reject { |c| c.empty? }

          ## For image url ##
          record << "image"
          record << listed_item.find('div[1]/img')[:src]

          ## Output here ##
          puts Hash[record.each_slice(2).to_a]
        end 
      end

    end
  end
end

## Call scrapper ##
stuerzer = StuerzerCrawler.new
stuerzer.scrape_page