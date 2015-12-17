dep 'MenuMeters.app' do
  source 'http://www.ragingmenace.com/software/download/MenuMeters.dmg'
end

dep 'VLC.app' do
  source "http://get.videolan.org/vlc/2.2.1/macosx/vlc-2.2.1.dmg"
end

dep 'VirtualBox.installer' do
  source "http://download.virtualbox.org/virtualbox/5.0.4/VirtualBox-5.0.4-102546-OSX.dmg"
end

dep 'Vagrant.installer' do
  requires 'VirtualBox.installer'

  met? {
    "/usr/local/bin/vagrant".p.exists?
  }

  source "https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4.dmg"
end

dep 'Dropbox.app' do
  source "https://www.dropbox.com/download?plat=mac"
end

dep 'Google Chrome.app' do
  source "http://dl.google.com/chrome/mac/dev/GoogleChrome.dmg"
end

dep 'FirefoxDeveloperEdition.app' do
  source "https://download.mozilla.org/?product=firefox-aurora-latest-ssl&os=osx&lang=en-US"
end

dep 'Transmission.app' do
  source 'https://transmission.cachefly.net/Transmission-2.84.dmg'
end

dep 'Sublime Text.app' do
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.dmg'

  meet {
    shell('sudo ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl')
  }
end

dep 'Google Drive.app' do
  source 'http://dl.google.com/drive/installgoogledrive.dmg'
end

dep 'all-osx-apps' do
  requires 'MenuMeters.app'
  requires 'VLC.app'
  requires 'VirtualBox.installer'
  requires 'Vagrant.installer'
  requires 'Google Chrome.app'
  requires 'Transmission.app'
  requires 'FirefoxDeveloperEdition.app'
  requires 'Sublime Text.app'
  requires 'Google Drive.app'
end

dep 'enable-full-disk-encryption' do
  met? {
    shell?("sudo fdesetup status").include? "On"
  }

  meet {
    shell("sudo fdesetup enable -user `whoami`")
  }
end

dep 'set-dock-magnification' do
  met? {
    shell?("defaults read com.apple.dock magnification") &&
      shell("defaults read com.apple.dock magnification").to_i == 1
  }

  meet {
    shell("defaults write com.apple.dock magnification -integer 1")
  }
end

dep 'auto-hide-dock' do
  met? {
    shell?("defaults read com.apple.dock autohide") &&
      shell("defaults read com.apple.dock autohide") == "1"
  }

  meet {
    shell("defaults write com.apple.dock autohide -bool true")
    shell("killall -HUP Dock")
  }
end

dep 'disable-widgets' do
  met? {
    cmd = "defaults read com.apple.dashboard mcx-disabled"
    shell?(cmd) &&
      shell(cmd).to_i == 1
  }

  meet {
    shell 'defaults write com.apple.dashboard mcx-disabled -boolean YES'
  }
end

dep 'fast-key-repeat' do
  met? {
    2 == shell('defaults read NSGlobalDomain KeyRepeat').to_i &&
      12 == shell('defaults read NSGlobalDomain InitialKeyRepeat').to_i
  }

  meet {
    shell('defaults write NSGlobalDomain KeyRepeat -int 2')
    shell('defaults write NSGlobalDomain InitialKeyRepeat -int 12')
  }
end

dep 'all-osx-settings' do
  requires 'fast-key-repeat'
  requires 'disable-widgets'
  requires 'auto-hide-dock'
end
