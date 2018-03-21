dep 'VLC.app' do
  source "http://get.videolan.org/vlc/2.2.1/macosx/vlc-2.2.1.dmg"
end

dep 'VirtualBox.installer' do
  source "http://download.virtualbox.org/virtualbox/5.0.4/VirtualBox-5.0.4-102546-OSX.dmg"
end

dep 'Google Chrome.app' do
  source "http://dl.google.com/chrome/mac/dev/GoogleChrome.dmg"
end

dep 'Firefox.app' do
  source "https://www.mozilla.org/en-US/firefox/new/?scene=2"
end

dep 'Atom.app' do
  source 'https://atom.io/download/mac'
end

dep 'Google Drive.app' do
  source 'http://dl.google.com/drive/installbackupandsync.dmg'
end

dep 'Docker.app' do
  source 'https://download.docker.com/mac/stable/Docker.dmg'
end

dep 'IntelliJ IDEA.app' do
  source 'https://www.jetbrains.com/idea/download/download-thanks.html?platform=mac'
end

dep 'all-osx-apps' do
  requires 'VLC.app'
  requires 'VirtualBox.installer'
  requires 'Google Chrome.app'
  requires 'Firefox.app'
  requires 'Atom.app'
  requires 'Google Drive.app'
  requires 'Docker.app'
  requires 'IntelliJ IDEA.app'
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
    shell?('defaults read NSGlobalDomain KeyRepeat') &&
      2 == shell('defaults read NSGlobalDomain KeyRepeat').to_i &&
        12 == shell('defaults read NSGlobalDomain InitialKeyRepeat').to_i
  }

  meet {
    shell('defaults write NSGlobalDomain KeyRepeat -int 2')
    shell('defaults write NSGlobalDomain InitialKeyRepeat -int 12')
  }
end

dep 'set-correct-fn-keys' do
  met? {
    shell?("defaults read -g com.apple.keyboard.fnState") &&
      shell("defaults read -g com.apple.keyboard.fnState") == "1"
  }

  meet {
    shell("defaults write -g com.apple.keyboard.fnState -bool true")
    shell("killall -HUP Dock")
  }
end

dep 'set-ask-for-password-on-sleep' do
  met? {
    shell?('defaults read com.apple.screensaver askForPassword') &&
      0 == shell('defaults read com.apple.screensaver askForPasswordDelay').to_i &&
        "1" == shell('defaults read com.apple.screensaver askForPassword')
  }

  meet {
    shell('defaults write com.apple.screensaver askForPasswordDelay -int 0')
    shell('defaults write com.apple.screensaver askForPassword -bool true')
  }
end

dep 'all-osx-settings' do
  requires 'fast-key-repeat'
  requires 'disable-widgets'
  requires 'auto-hide-dock'
  requires 'set-correct-fn-keys'
  requires 'set-ask-for-password-on-sleep'
end
