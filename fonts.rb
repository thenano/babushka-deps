dep 'user font dir exists' do
  met? {
    "~/Library/Fonts".p.dir?
  }
  meet {
    log_shell "Creating ~/Library/Fonts", "mkdir ~/Library/Fonts"
  }
end

meta 'font' do
  accepts_list_for :source
  accepts_list_for :extra_source
  accepts_list_for :ttf_filename

  template {
    requires 'user font dir exists'

    met? {
      "~/Library/Fonts/#{ttf_filename.first}".p.exists?
    }

    meet {
      source.each do |uri|
        Babushka::Resource.extract(uri) do
          Dir.glob("*.?tf") do |font|
            log_shell "Installing #{font}", "cp '#{font}' ~/Library/Fonts"
          end
        end
      end
    }
  }
end

dep 'inconsolata.font' do
  source 'http://www.fontsquirrel.com/fonts/download/Inconsolata'
  ttf_filename "Inconsolata.otf"
end

dep 'open-sans.font' do
  source 'http://www.fontsquirrel.com/fonts/download/open-sans'
  ttf_filename 'OpenSans-Regular.ttf'
end

dep 'hack.font' do
  source 'https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip'
  ttf_filename 'Hack-Regular.ttf'
end

dep 'all-fonts' do
  requires 'inconsolata.font'
  requires 'open-sans.font'
  #requires 'hack.font'
end
