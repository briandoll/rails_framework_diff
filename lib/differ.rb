module RailsFrameworkDiff
class Differ < Object
  
  def initialize(*args)
    @project_dir   = args[0] || "." # assume current directory if not defined
    @rails_version = args[1] || get_rails_version_from_project
    
    # we can rely on rails_version's nilness as badness since we can't get the version
    # number unless the project was specified correctly too.
    if @rails_version.nil?
      usage
    else
      diff
    end
  end
  
  DIFF_OPTIONS = " --ignore-blank-lines "
  
  # Maps the framework generated file directories to the project directories
  COMPARISON_PATHS = {
    "/dispatches/" => "/public/",
    "/configs/"    => "/config/",
    "/bin/"        => "/script/"    
  }
  
  # Unfortunately, not all directories in the rails gem map directly to a project dir
  # so here we have file-by-file mappings.  
  COMPARISON_FILES = {
    "/environments/boot.rb"          => "/config/boot.rb",
    "/environments/environment.rb"   => "/config/environment.rb",
    "/environments/development.rb"   => "/config/environments/development.rb",
    "/environments/production.rb"    => "/config/environments/production.rb",
    "/environments/test.rb"          => "/config/environments/test.rb",
    "/helpers/application.rb"        => "/app/controllers/application.rb",
    "/helpers/application_helper.rb" => "/app/helpers/application_helper.rb",
    "/helpers/test_helper.rb"        => "/test/test_helper.rb"
  }
  
  private
  
  def project_path        
    File.expand_path(File.join(Dir.getwd, @project_dir))
  end

  # determine what the rails version is by inspecting the project's gem_version
  # as defined in the project's boot.rb file
  def get_rails_version_from_project    
    rails_boot_file = File.expand_path(File.join(project_path, '.', 'config', 'boot.rb'))
    if FileTest.exists? rails_boot_file
      require rails_boot_file
      return @rails_version ||= Rails::GemBoot.gem_version
    end
  end
  
  # ha!  such a hack.  any suggestions on how to pull this off otherwise?
  def get_path_to_rails_gem
    path = ''
    rails_gem_contents = `gem contents rails -v #{get_rails_version_from_project}`
    rails_gem_contents.each_line do |contents|
      path_elements = contents.split(File::SEPARATOR)
      path_elements.pop
      path = path_elements.join(File::SEPARATOR)
      break
    end
    path
  end
  
  # returns a hash representing all framework files mapped to corresponding project files
  def files_to_diff
    files = {}
    COMPARISON_PATHS.each do |framework_dir, project_dir|
      Dir.new("#{get_path_to_rails_gem}#{framework_dir}").entries.reject { |e| /^\./.match(e) }.each do |file|
        framework_file = "#{get_path_to_rails_gem}#{framework_dir}#{file}"
        project_file   = "#{project_path}#{project_dir}#{file}" 
        files[framework_file] = project_file
      end
    end
    
    COMPARISON_FILES.each do |framework_file, project_file|
      files["#{get_path_to_rails_gem}#{framework_file}"] = "#{project_path}#{project_file}"
    end
    
    files
  end
 
  def diff
    output = []
    output << "Diffing Rails version #{get_rails_version_from_project} with the #{@project_dir} project:"    
      files_to_diff.each do |framework_file, project_file|
      output << "Diffing:\n<   #{framework_file}\n>   #{project_file}"
      output << `diff #{framework_file} #{project_file}`
      output << "###"
    end
    puts output.join("\n")    
  end
  
  def usage
u = <<EOF
  rails_framework_diff projectname [rails version]
    projectname:   must be a valid relative path
    rails version: optional, specify as '2.1.0' if you intend to diff from the non-default version
EOF
    puts u
  end
  
end
end