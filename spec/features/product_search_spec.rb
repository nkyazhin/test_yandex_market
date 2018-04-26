require 'spec_helper'

feature "Produc search", js: true do
  # let(:document_name) { 'нк ч2' }
  # let(:delay_open_document) { Config.new.delay_open_document }

  scenario '#find document' do
    visit_yandex_start_page
    # open_yandex_market_page
    open_link_page('Маркет')
    open_link_page('Электроника')
    open_link_page('Телевизоры')
    # open_link_page('Перейти ко всем фильтрам')
    # page.fill_in 'glf-pricefrom-var', with: '20000'
    # click_button 'Показать всё'
    # page.find(:xpath, "//div[@data-filter-id='7893318']//input").set('Samsung')
    # page.find(:xpath, "//div[@data-filter-id='7893318']//label[text()='Samsung']").click
    # page.find(:xpath, "//div[@data-filter-id='7893318']//input").set('LG')
    # page.find(:xpath, "//div[@data-filter-id='7893318']//label[text()='LG']").click
    # click_link 'Показать подходящие'
    page.find(:xpath, "//button[contains(@class,'select')]").click
    page.find(:xpath, "//span[@class='select__text' and contains(.,'Показывать по 12')]").click
    puts '11111111'
    items_div_title = page.all(:xpath, "//div[contains(@class,'n-snippet-list')]//div[@class='n-snippet-card2__title']")
    puts items_div_title.count
    puts '222222'
    expect(items_div_title.size).to eq 12
    first_item_title = items_div_title.first.text
    page.fill_in 'header-search', with: first_item_title
    expect(page).to have_xpath("//div[@class='n-title__text']//hi[text()='#{first_item_title}']")
    sleep 15
  end

  private

  def visit_yandex_start_page
    visit '/'
  end

  def open_yandex_market_page
    page.find(:xpath, "//a[@data-statlog='tabs.market']").click
  end

  def open_link_page(link)
    click_link link, match: :first
  end
end
