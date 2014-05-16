# -*- encoding: utf-8 -*-

require 'spec_helper'

module Xpath
  module Specs

    describe ContainA do

      context 'direct matching' do

        before :each do
          @html_with_link = '<html>
                              <head></head>
                              <body>
                               <a href="#">Click Me !</a>
                              </body>
                             </html>'

          @blank_html = '<html>
                          <head></head>
                          <body>
                          </body>
                         </html>'

          @link = PagePart.new("<my link>", '//a')
        end

        it 'matches an existing xpath' do
          expect(@html_with_link).to contain_a(@link)
        end

        it 'has better error messages for missing xpath' do
          expect do
            expect(@blank_html).to contain_a(@link)
          end.to raise_error(Regexp.new("expected the page to contain <my link> \\(\\/\\/a\\)"+
                                        "\\s+but could not find <my link> \\(\\/\\/a\\)"))
        end

        it 'has clear error messages for unexpected xpath' do
          expect do
            expect(@html_with_link).not_to contain_a(@link)
          end.to raise_error(/expected the page not to contain <my link> \(\/\/a\)/)
        end

        it 'automaticaly works on body attributes' do
          expect(double(:body => @html_with_link)).to contain_a(@link)
        end

      end

      context 'nesting xpath' do

        before :each do
          @html_with_link = '<html>
                              <head></head>
                              <body>
                               <div>
                                <a href="#">Click Me !</a>
                               </div>
                              </body>
                             </html>'

          @html_without_link = '<html>
                                 <head></head>
                                 <body>
                                  <div></div>
                                 </body>
                                </html>'

          @nested_link = PagePart.new("<my div>", '//div').with('<my nested link>', '/a')
        end

        it 'matches a nested xpath' do
          expect(@html_with_link).to contain_a(@nested_link)
        end
        it 'has even better error messages for missing nested xpath' do
          expect do
            expect(@html_without_link).to contain_a(@nested_link)
          end.to raise_error(Regexp.new("expected the page to contain <my nested link> \\(\\/\\/div\\/a\\)"+
                                        "\\s+it found <my div> \\(\\/\\/div\\) :"+
                                        "\\s+<div><\\/div>"+
                                        "\\s+but not <my nested link> \\(\\/\\/div\\/a\\)"))
        end

        it 'supports nesting xpath the other way round' do
          link_within = PagePart.new('link', '//a').within_a(PagePart.new('div', '//div'))

          expect(link_within.xpath).to eq('//div//a')
        end
        it 'supports specializing xpath' do
          red_link = PagePart.new('link', '//a').that('is red', "[@class='red']")

          expect(red_link.xpath).to eq("//a[@class='red']")
          expect(red_link.description).to eq('link that is red')
        end

      end

    end
  end
end
