# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::Capybara::VisibilityMatcher do
  subject(:cop) { described_class.new }

  it 'registers an offense when using `visible: true`' do
    expect_offense(<<-RUBY)
      expect(page).to have_selector('.my_element', visible: true)
                                                   ^^^^^^^^^^^^^ Use `:visible` instead of `true`.
    RUBY
  end

  it 'registers an offense when using `visible: false`' do
    expect_offense(<<-RUBY)
      expect(page).to have_selector('.my_element', visible: false)
                                                   ^^^^^^^^^^^^^^ Use `:all` or `:hidden` instead of `false`.
    RUBY
  end

  it 'registers an offense when using a selector`' do
    expect_offense(<<-RUBY)
      expect(page).to have_selector(:css, '.my_element', visible: false)
                                                         ^^^^^^^^^^^^^^ Use `:all` or `:hidden` instead of `false`.
    RUBY
  end

  it 'registers an offense when using a using multiple options`' do
    expect_offense(<<-RUBY)
      expect(page).to have_selector('.my_element', count: 1, visible: false, normalize_ws: true)
                                                             ^^^^^^^^^^^^^^ Use `:all` or `:hidden` instead of `false`.
    RUBY
  end

  it 'does not register an offense when no options are given`' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_selector('.my_element')
    RUBY
  end

  it 'does not register an offense when using `visible: :all`' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_selector('.my_element', visible: :all)
    RUBY
  end

  it 'does not register an offense when using `visible: :visible`' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_selector('.my_element', visible: :visible)
    RUBY
  end

  it 'does not register an offense when using `visible: :hidden`' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_selector('.my_element', visible: :hidden)
    RUBY
  end

  it 'does not register an offense when using other options' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_selector('.my_element', normalize_ws: true)
    RUBY
  end

  it 'does not register an offense when using multiple options' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_selector('.my_element', count: 1, normalize_ws: true)
    RUBY
  end
end
