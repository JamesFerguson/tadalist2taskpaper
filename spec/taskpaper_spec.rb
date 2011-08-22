Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each { |f| require f }

describe "Taskpaper File" do
  before(:all) do
    @lists = [
      ["Test 1:List One", "http://tadalistscrapertest.tadalist.com/lists/1845979", ["item one", "item two"]],
      ["Test 1:List One:Extra", "http://tadalistscrapertest.tadalist.com/lists/1862508", ["abc", "def"]],
      ["Test 1:List Two", "http://tadalistscrapertest.tadalist.com/lists/1845980", ["item three http://www.test.com", "item four"]],
      ["Test 2", "http://tadalistscrapertest.tadalist.com/lists/1862509", ["this is a test"]]
    ]
    
    @tp = TaskPaper::File.new(@lists)
  end

  it "turns a list matrix into a taskpaper file" do
    @tp.to_s.should == <<-MASTERLIST
Projects:
	Test 1:
		List One (http://tadalistscrapertest.tadalist.com/lists/1845979):
			- item one
			Extra (http://tadalistscrapertest.tadalist.com/lists/1862508):
				- abc
		List Two (http://tadalistscrapertest.tadalist.com/lists/1845980):
			- item three http://www.test.com
	Test 2 (http://tadalistscrapertest.tadalist.com/lists/1862509):
		- this is a test
MASTERLIST
  end
end