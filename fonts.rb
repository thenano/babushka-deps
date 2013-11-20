dep 'inconsolata.otf' do
  source 'http://www.levien.com/type/myfonts/Inconsolata.otf'
  otf_filename "Inconsolata.otf"
end

dep 'all-fonts' do
  requires 'inconsolata.otf'
end
