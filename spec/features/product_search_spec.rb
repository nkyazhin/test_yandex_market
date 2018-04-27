require 'spec_helper'

feature "Produc search", js: true do
  # let(:document_name) { 'нк ч2' }
  # let(:delay_open_document) { Config.new.delay_open_document }

  # scenario '#find tv' do
  #   visit_yandex_start_page
  #   open_link_page('Маркет')
  #   open_link_page('Электроника')
  #   open_link_page('Телевизоры')
  #   open_link_page('Перейти ко всем фильтрам')
  #   page.fill_in 'glf-pricefrom-var', with: '20000'
  #   click_button 'Показать всё'
  #   page.find(:xpath, "//div[@data-filter-id='7893318']//input").set('Samsung')
  #   page.find(:xpath, "//div[@data-filter-id='7893318']//label[text()='Samsung']").click
  #   page.find(:xpath, "//div[@data-filter-id='7893318']//input").set('LG')
  #   page.find(:xpath, "//div[@data-filter-id='7893318']//label[text()='LG']").click
  #   click_link 'Показать подходящие'
  #   page.find(:xpath, "//button[contains(@class,'select')]").click
  #   page.find(:xpath, "//span[@class='select__text' and contains(.,'Показывать по 12')]").click
  #   expect(page).to have_xpath("//div[@class='n-snippet-card2__title']", count: 12)
  #   first_element_title = page.find(:xpath, "//div[@class='n-snippet-card2__title']", match: :first).text
  #   page.fill_in 'header-search', with: first_element_title
  #   click_button 'Найти'
  #   expect(page).to have_xpath("//h1[contains(@class,'title') and contains(.,'#{first_element_title}')]")
  # end

  scenario '#find headphones'do
  visit_yandex_start_page
  open_link_page('Маркет')
  open_link_page('Электроника')
  open_link_page('Наушники')
  # Чтобы загружалось по 12 товаров
  page.find(:xpath, "//button[contains(@class,'select')]").click
  page.find(:xpath, "//span[@class='select__text' and contains(.,'Показывать по 12')]").click
  open_link_page('Перейти ко всем фильтрам')
  page.fill_in 'glf-pricefrom-var', with: '5000'
  click_button 'Показать всё'
  page.find(:xpath, "//div[@data-filter-id='7893318']//input").set('Beats')
  page.find(:xpath, "//div[@data-filter-id='7893318']//label[text()='Beats']").click
  click_link 'Показать подходящие'
  expect(page).to have_xpath("//div[@class='n-snippet-cell2__title']", count: 12)
  first_element_title = page.find(:xpath, "//div[@class='n-snippet-card2__title']", match: :first).text
  page.fill_in 'header-search', with: first_element_title
  click_button 'Найти'

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
