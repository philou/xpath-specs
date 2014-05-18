# -*- encoding: utf-8 -*-

module Xpath
  module Specs

    # XPath wrapper providing a user friendly description.
    # Should be used with the contain_a rspec matcher.
    class PagePart

      # description: user friendly text used in assertions error messages
      # xpath: the actual xpath to search for
      # parent: an optional parent page part, used to provide better assertion
      # failure diagnostic
      def initialize(description, xpath, parent = nil)
        @xpath = xpath
        @description = description
        @parent = parent
      end

      attr_reader :parent, :description, :xpath

      def has_parent
        !parent.nil?
      end

      # A full description containing the xpath
      def long_description
        "#{description} (#{xpath})"
      end

      # Creates another PagePart instance to match elements relatively to self
      # Uses a completely new description. It's the prefered way to mach sub
      # elements
      def with(description, xpath)
        PagePart.new(description, self.xpath+xpath, self)
      end

      # Creates another PagePart instance to match elements relatively to self
      # Concatenates the descriptions. It's the prefered way to add constraints
      # to the currently matched elements
      def that(description, xpath)
        PagePart.new("#{self.description} that #{description}",
                     self.xpath+xpath,
                     self)
      end

      # Creates another PagePart instance like self, but relatively to another
      # existing page part.
      def within_a(outer_page_part)
        outer_page_part.with(self.description, self.xpath)
      end
    end

  end
end
