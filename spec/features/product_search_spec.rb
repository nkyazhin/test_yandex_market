require 'spec_helper'

feature "Produc search", js: true do
  let(:tv_manufacturers)           { ['Samsung', 'LG'] }
  let(:headphones_manufacturers)   { ['Beats'] }

  scenario '#find tv' do
    visit_yandex_start_page
    open_link_page('Маркет')
    open_link_page('Электроника')
    open_link_page('Телевизоры')
    open_link_page('Перейти ко всем фильтрам')
    page.fill_in 'glf-pricefrom-var', with: '20000'
    filte_by_manufacturer(tv_manufacturers)
    click_link 'Показать подходящие'
    # Чтобы загружалось по 12 товаров
    select_quantity_of_goods
    expect(page).to have_xpath("//div[@class='n-snippet-card2__title']", count: 12)
    first_element_title = page.find(:xpath, "//div[@class='n-snippet-card2__title']", match: :first).text
    page.fill_in 'header-search', with: first_element_title
    click_button 'Найти'
    expect(page).to have_xpath("//h1[contains(@class,'title') and contains(.,'#{first_element_title}')]")
  end

  scenario '#find headphones'do
    visit_yandex_start_page
    open_link_page('Маркет')
    open_link_page('Электроника')
    open_link_page('Наушники')
    # Чтобы загружалось по 12 товаров
    select_quantity_of_goods
    open_link_page('Перейти ко всем фильтрам')
    page.fill_in 'glf-pricefrom-var', with: '5000'
    filte_by_manufacturer(headphones_manufacturers)
    click_link 'Показать подходящие'
    expect(page).to have_xpath("//div[@class='n-snippet-cell2__title']", count: 12)
    first_element_title = page.find(:xpath, "//div[@class='n-snippet-cell2__title']", match: :first).text
    page.fill_in 'header-search', with: first_element_title
    click_button 'Найти'
    expect(page).to have_xpath("//div[@class='n-snippet-cell2__title' and contains(.,'#{first_element_title}')]")
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

  def select_quantity_of_goods
    page.find(:xpath, "//button[contains(@class,'select')]").click
    page.find(:xpath, "//span[@class='select__text' and contains(.,'Показывать по 12')]").click
  end

  def filte_by_manufacturer(manufacturers)
    click_button 'Показать всё'
    manufacturers.each do |manufacturer|
      page.find(:xpath, "//div[@data-filter-id='7893318']//input").set(manufacturer)
      page.find(:xpath, "//div[@data-filter-id='7893318']//label[text()='#{manufacturer}']").click
    end
  end
end
