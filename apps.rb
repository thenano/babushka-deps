packaged_apps = %w{
  zsh
  vim
  pass
  wget
  tree
  gpg
}

packaged_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

dep "homebrew-games" do
  met? {
    shell("brew tap").include? "homebrew/games"
  }

  meet {
    shell("brew tap homebrew/games")
  }
end

games = %w{
  nethack
}

games.each do |app, ps|
  dep "#{app}.bin" do
    requires "homebrew-games"
    installs app
    provides ps
  end
end

dep 'all-packaged-apps' do
  requires *(packaged_apps).map { |a| "#{a}.bin" }
  requires 'vundle plugins up to date.vim'
  requires 'vundle up to date.repo'
end

dep 'vundle plugins up to date.vim' do
  requires 'vundle up to date.repo'

  met? { shell? 'vim +PluginInstall! +PluginClean! +qall 2&> /dev/null' }
end

dep 'vundle up to date.repo' do
  requires 'vim.bin'
  source 'https://github.com/gmarik/Vundle.vim'
  path '~/.vim/bundle/Vundle.vim'
end
