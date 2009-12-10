# encoding: utf-8
require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'Rails filters' do
  before :all do
    @en = R18n::Locale.load('en')
  end
  
  it "should use named variables" do
    i18n = R18n::Translation.new(@en, '', @en, {'echo' => 'Value is {{value}}'})
    
    i18n.echo(:value => 'R18n').should == 'Value is R18n'
    i18n.echo(:value => -5.5).should == 'Value is −5.5'
    i18n.echo(:value => 5000).should == 'Value is 5,000'
    i18n.echo.should == 'Value is {{value}}'
  end
  
  it "should pluralize by variable {{count}}" do
    i18n = R18n::Translation.new(@en, '', @en, {'users' => R18n::Typed.new('pl',
      { 0 => 'no users', 1 => '1 user', 'n' => '{{count}} users' }
    ) })
    
    i18n.users(:count => 0).should == 'no users'
    i18n.users(:count => 1).should == '1 user'
    i18n.users(:count => 5).should == '5 users'
  end
  
end
