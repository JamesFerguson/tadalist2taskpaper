module TaskPaper
  class File
    attr_accessor :lists_hash
    
    def initialize(lists_matrix)
      @lists_hash = parse_matrix(lists_matrix)
    end
    
    def to_s
      @lists_hash[:projects].reduce("Projects:\n") do |str, project|
        project_name, (project_link, (project_next_step, *)) = project
        
        str += <<-PROJECT
	#{project_name} (#{project_link}):
		- #{project_next_step}
PROJECT
      end
    end
    
    private
    
    def parse_matrix(lists_matrix)
      lists_hash = {:projects => {}}
      
      lists_matrix.each do |list_arr|
        lists_hash[:projects][list_arr.first] = list_arr[1..list_arr.size]
      end
      
      lists_hash
    end
  end
end