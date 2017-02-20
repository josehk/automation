describe 'Add to Cart' do

  before :all do
    #Constructors
    browser = :chrome #or :firefox
    @driver = Watir::Browser.new browser
    @goulet = GouletModel.new @driver

    #Test specific data
    @title = "The Goulet Pen Company"
    @item1 = "Lamy Safari Fountain Pen - GREEN, MEDIUM"
    @prod1 = "LMY-L13GNM"

    @item2 = "Lamy Safari Fountain Pen - Shiny Black, MEDIUM"
    @prod2 = "LMY-L19BKM"

    @prod3 = "LMY-L17M"
    @prod4 = "LMY-L19BKEF"

    @cart_url = "https://www.gouletpens.com/cart"
  end
  
  it 'should navigate to gouletpens.com' do
    @goulet.browse  #default page is already defined as gouletpens.com
    expect(@driver.title).to eq @title
  end

  it 'should search and add item 1 to cart' do
    @goulet.search_item @item1
    sleep 3
    p1 = @goulet.product @prod1

    #If p1 is nil it means product couldn't be found
    expect(p1).not_to be_nil

    @goulet.product_quick_shop p1
    sleep 3

    #After adding the product the cart monitor should change
    expect(@goulet.cart_monitor_items).to eq "1"
  end

  it 'should search and add item 2 to cart' do
    @goulet.search_item @item2
    sleep 3
    p2 = @goulet.product @prod2
    expect(p2).not_to be_nil
    @goulet.product_quick_shop p2
    sleep 3
    expect(@goulet.cart_monitor_items).to eq "2"
  end

  it 'should add 2 additional items to cart' do
    p3 = @goulet.product @prod3
    @goulet.product_quick_shop p3
    sleep 3
    #Scrolling up to check the number of items in the cart monitor
    @driver.execute_script('arguments[0].scrollIntoView();', @goulet.cart_monitor)
    expect(@goulet.cart_monitor_items).to eq "3"

    sleep 3 #give the browser a break

    p4 = @goulet.product @prod4
    @goulet.product_quick_shop p4
    sleep 3
    @driver.execute_script('arguments[0].scrollIntoView();', @goulet.cart_monitor)
    expect(@goulet.cart_monitor_items).to eq "4"
  end

  it 'should find 4 items are in cart' do
    @goulet.browse @cart_url
    expect(@driver.url).to eq @cart_url
    @goulet.cart_list
    expect(@goulet.cart_list_product_code 1).to eq @prod1
    expect(@goulet.cart_list_product_code 2).to eq @prod2
    @goulet.cart_scroll_to 3
    expect(@goulet.cart_list_product_code 3).to eq @prod3
    @goulet.cart_scroll_to 4
    expect(@goulet.cart_list_product_code 4).to eq @prod4
  end

end
