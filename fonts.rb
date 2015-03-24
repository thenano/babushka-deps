dep 'inconsolata.otf' do
  source 'http://www.levien.com/type/myfonts/Inconsolata.otf'
  otf_filename "Inconsolata.otf"
end

dep 'open-sans.ttf' do
  source 'http://www.fontsquirrel.com/fonts/download/open-sans'
  ttf_filename 'OpenSans-Regular.ttf'
end

dep 'all-fonts' do
  requires 'inconsolata.otf'
  requires 'open-sans.ttf'
end
