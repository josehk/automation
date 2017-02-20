class GouletModel

  def initialize driver
    @driver = driver
    @main_uri = "http://gouletpens.com"
  end

  def browse url = @main_uri
    @driver.goto url
  end

  def refresh
    @driver.refresh
  end

  def close
    @driver.close
  end

  #Element Abstraction
  def search_field
    #This website has some extra elements in the main page (probably decorators)
    # those elements have the same class, container or type but they are not visible
    if @driver.text_fields[0].visible?
      @driver.text_fields[0]
    else
      @driver.text_fields[1]
    end
  end

  def search_button
    if @driver.buttons[0].visible?
      @driver.buttons[0]
    else
      @driver.buttons[1]
    end
  end

  def btn_add_to_cart
    @driver.div(:class, "btnAddToCart").button
  end

  def cart_monitor
    @driver.div(:id, "cartmonitorBlock")
  end

  def cart_monitor_items
    cart_monitor.spans[1].text
  end

  def modal_dialog
    @driver.div(:class, "modal-dialog")
  end

  ### Each item in the cart list has 16 divs starting from index number 3
  # cartlist.divs[3+16+16+16]
  def cart_list
    @driver.div(:id, "cart")
  end

  def cart_scroll_to row
    row = row - 1
    divrow = 3 + 16*row
    @driver.execute_script('arguments[0].scrollIntoView();', cart_list.divs[divrow])
  end

  ### Each product code is in the fifth div from each product
  def cart_list_product_code row
    row = row - 1
    divrow = 8 + 16*row
    cart_list.divs[divrow].spans[1].text
  end

  #Functions
  def search_item name
    search_field.set name
    search_button.click
  end

  def product product_code
    #There are many elements with the same class, the only unique identifier is a custom tag
    sleep 2
    @driver.div(:xpath, "//div[@data-mz-product='#{product_code}']")
  rescue Watir::Exception::UnknownObjectException
    p "Not found"
    return nil
  end

  def product_quick_shop prod
    prod.click
    prod.span(:class, "mz-price actual-price").click
    prod.span(:text, "Quick Shop").click
    modal_dialog.wait_until_present
    btn_add_to_cart.wait_until_present
    btn_add_to_cart.click
  end

end


# browser = :chrome #or :firefox
# driver = Watir::Browser.new browser
#
# page = GouletModel.new driver
# page.browse
#
# page.search_item "Lamy Safari Fountain Pen - GREEN, MEDIUM"
# sleep 3
# p1 = page.product "LMY-L13GNM"
#
# if p1.nil?
#   p "product doesn't exist"
# end
#
# page.product_quick_shop p1
# sleep 3
# p page.cart_monitor_items


