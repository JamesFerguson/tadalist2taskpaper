require 'yaml'
Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each { |f| require f }

describe "TaDaList Account" do
  before(:all) do
    login = YAML::parse(File.open(File.dirname(__FILE__) + '/tadalist_account.yml')).transform
    @acct = TaDaList::Account.new(login["username"], login["password"])
  end

  it "returns all list names mapped to urls" do
    lists = @acct.lists
    
    lists.should == [
      ["Test 1:List One", "http://tadalistscrapertest.tadalist.com/lists/1845979", ["item one", "item two"]],
      ["Test 1:List One:Extra", "http://tadalistscrapertest.tadalist.com/lists/1862508", ["abc", "def"]],
      ["Test 1:List Two", "http://tadalistscrapertest.tadalist.com/lists/1845980", ["item three http://www.test.com", "item four"]],
      ["Test 2", "http://tadalistscrapertest.tadalist.com/lists/1862509", ["this is a test"]]
    ]
  end
end