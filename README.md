[![Build Status](https://travis-ci.org/philou/xpath-specs.svg?branch=master)](https://travis-ci.org/philou/xpath-specs) [![Test Coverage](https://codeclimate.com/github/philou/xpath-specs/badges/coverage.svg)](https://codeclimate.com/github/philou/xpath-specs) [![Code Climate](https://codeclimate.com/github/philou/xpath-specs/badges/gpa.svg)](https://codeclimate.com/github/philou/xpath-specs)

# Xpath::Specs

An RSpec library to get better messages when matching XPaths

## Installation

Add this line to your application's Gemfile:

    gem 'xpath-specs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xpath-specs

## Usage

As an example, suppose you have website with dishes and receipes. You want to test your views (either in RSpec or Cucumber) to make sure that they contain parts you want them to.

### Declare your page parts

In order to encourage reuse, create one or many custom page part definition files

```ruby
# spec/support/knows_page_parts.rb

module KnowsPageParts
  def dish_panel
    Xpath::Specs::PagePart.new("the dish panel", "//table[@id='dish-panel']")
  end

  def dish
    # match a sub element of dish_panel
    dish_panel.with("a dish", "//tr")
  end

  def dish_with_name(name)
    # match a special dish
    dish.that("is named #{name}", "[td[contains(.,'#{name}')]]")
  end
end

```

### Use them in your specs

With these page parts definitions in place, you can now use them to test your views. Suppose this is the html for your view :

```html
<html>
 <head></head>
 <body>
  <div>
   <table id="dish-panel">
    <tr><td>Pizza</td>...</tr>
    <tr><td>Cheese Burger</td>...</tr>
    ...
   </table>
  </div>
 </body>
</html>
```

* You can test that your view contains the dish panel :

```ruby
expect(html).to contain_a(dish_panel)
```

* You can test that it contains at least one dish

```ruby
expect(html).to contain_a(dish)
```

* You can also test that it contains a pizza

```ruby
expect(html).to contain_a(dish_with_name("Pizza")
```

* Eventually, if you try to search for a dish that is not there :

```ruby
expect(html).to contain_a(dish_with_name("Grilled Lobster")
```

You'll get a nice error message :

```
expected the page to contain a dish that is named Grilled Lobster (//table[@id='dish-panel']//tr[td[contains(.,'#{name}')]])
       it found a dish (//table[@id='dish-panel']//tr) :
          <tr><td>Pizza</td>...</tr>
       but not a dish that is named Grilled Lobster (//table[@id='dish-panel']//tr[td[contains(.,'#{name}')]])
```

### Testing from Cucumber

Just use the 'page' in place of your view :

```ruby
expect(page).to contain_a(dish_panel)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
