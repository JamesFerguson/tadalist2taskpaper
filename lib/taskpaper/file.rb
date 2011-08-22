module TaskPaper
  class File
    attr_accessor :lists_hash
    
    def initialize(lists_matrix)
      @lists_matrix = lists_matrix
    end
    
    def to_s
      last_project = []
      
      @lists_matrix.reduce("Projects:\n") do |str, project|
        tabs = ""
        project_name, project_link, (project_next_step, *) = project
        project_name = project_name.split(/:/)
        project_name.each.with_index do |name_part, index|
          if index < project_name.size - 1 && last_project[index] != name_part
            str += "#{tabs}	#{name_part}:\n"
          end
          tabs += "\t"
        end
        
        str += <<-PROJECT
#{tabs}#{project_name.last} (#{project_link}):
#{tabs}	- #{project_next_step}
PROJECT
        
        last_project = project_name
        str
      end
    end
  end
end