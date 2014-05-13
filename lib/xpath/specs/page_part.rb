# -*- encoding: utf-8 -*-

module Xpath
  module Specs

    class PagePart
      def initialize(description, xpath, parent = nil)
        @xpath = xpath
        @description = description
        @parent = parent
      end

      attr_reader :parent, :description, :xpath

      def has_parent
        !parent.nil?
      end

      def long_description
        "#{description} (#{xpath})"
      end

      def with(description, xpath)
        PagePart.new(description, self.xpath+xpath, self)
      end
      def within_a(outer_page_part)
        outer_page_part.with(self.description, self.xpath)
      end
      def that(description, xpath)
        PagePart.new("#{self.description} that #{description}", self.xpath+xpath, self)
      end

    end

  end
end
