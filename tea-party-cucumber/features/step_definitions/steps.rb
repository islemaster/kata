$:.unshift(File.dirname(__FILE__) + '/../..')
require 'guest'

Given(/^(?:my|a) guest (?:is )?named (.*)$/i) do |name|
    @guest = Guest.new(name)
end

Given(/^(?:s?he|they) (?:is|are) (?:a )?(man|woman|male|female)$/) do |gender|
    if (gender == "man" or gender == "male")
        @guest.gender = :male
    else
        @guest.gender = :female
    end
end

Given(/^(?:s?he|they) (?:is|are)(n't| not| un)? ?married$/) do |married|
    if (married.nil?)
        @guest.married = true
    end
end

Given(/^(?:s?he|they) (?:is|are)(n't| not)? knighted$/) do |knighted|
    if (knighted.nil?)
        @guest.knighted = true
    end
end

When(/^I greet (?:her|him|them)$/) do
    @greeting = @guest.greet
end

Then(/^I should say "([^"]*)"$/) do |expectedGreeting|
    @greeting.should == expectedGreeting
end
