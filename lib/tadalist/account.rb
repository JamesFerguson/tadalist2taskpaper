require 'mechanize'
# require 'logger'

module TaDaList
  class Account
    attr_accessor :lists
    
    def initialize(username, password)
      list_index_page = login(username, password)
      @lists = list_index_page.links_with(:href => /lists\/\d+/).map do |link|
        list_page = link.click
        list_items = list_page.forms_with(:action => /\/lists\/\d+\/items\/\d+/).map do |form|
          form.form_node.content.strip
        end
        [list_page.title, list_page.uri.to_s, list_items]
      end.sort
    end
    
    private
    
    def login(username, password)
      agent = Mechanize.new #{ |a| a.log = Logger.new("tmp/mech.log") }
      agent.user_agent_alias = 'Mac Safari'
      page = agent.get("http://#{username.downcase}.tadalist.com/")
      
      login_form = page.form_with(:action => '/session')
      login_form.field_with(:name => "username").value = username
      login_form.field_with(:name => "password").value = password
      
      agent.submit(login_form)
    end
  end
end