dep 'VLC.app' do
  source "http://get.videolan.org/vlc/2.2.1/macosx/vlc-2.2.1.dmg"
end

dep 'VirtualBox.installer' do
  source "http://download.virtualbox.org/virtualbox/5.0.4/VirtualBox-5.0.4-102546-OSX.dmg"
end

dep 'Google Chrome.app' do
  source "http://dl.google.com/chrome/mac/dev/GoogleChrome.dmg"
end

dep 'FirefoxDeveloperEdition.app' do
  source "https://download.mozilla.org/?product=firefox-aurora-latest-ssl&os=osx&lang=en-US"
end

dep 'Atom.app' do
  source 'https://atom.io/download/mac'
end

dep 'Google Drive.app' do
  source 'http://dl.google.com/drive/installgoogledrive.dmg'
end

dep 'all-osx-apps' do
  requires 'VLC.app'
  requires 'VirtualBox.installer'
  requires 'Google Chrome.app'
  requires 'FirefoxDeveloperEdition.app'
  requires 'Atom.app'
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
