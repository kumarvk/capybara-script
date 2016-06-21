## Contain commaon functionality ##

module Support

    def get_array_for(anchor_xpath)
      sub_menus = []
      page.all(anchor_xpath).each do |element|
        sub_menus << element
      end
    end

end