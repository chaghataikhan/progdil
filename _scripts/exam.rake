require 'erb'
require 'yaml'

gecici = 'progdil-2011.md'

task :exam do
  s = Hash.new()
	oku = YAML::load(File.open('_exams/progdil-2011.yml')) 
	temp = ERB.new(File.read('_templates/exam.md.erb'))
	
	oku['q'].each do |soru|
		s[soru] = File.read('_includes/q/'+soru)
	end
	dosya = File.new(gecici,'w')
	dosya.write(temp.result(binding))
	dosya.close
	sh %( markdown2pdf #{gecici} )
	sh %( rm -rf #{gecici} )
end