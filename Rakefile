HOME = ENV['HOME']
CWD = File.dirname __FILE__

BLACKLIST = %w[README.markdown Rakefile]
DOTFILES = FileList['*'] - BLACKLIST

DOTFILES.each do |f|
  desc "Install ~/.#{f} by symlinking"
  task f do |t|
    target = "#{HOME}/.#{t.name}"
    source = "#{CWD}/#{t.name}"
    File.symlink source, target unless File.exists? target
  end
end

task :bashrc => :commonshrc
task :zshrc => :commonshrc

TMP_DIR = "#{HOME}/.tmp"
directory TMP_DIR
task :vimrc => TMP_DIR

NEOBUNDLE_REPO = 'http://github.com/Shougo/neobundle.vim'
directory 'vim/bundle'
task 'neobundle.vim' => ['vim/bundle'] do |t|
  neobundle_root = "vim/bundle/#{t.name}"
  sh "git clone #{NEOBUNDLE_REPO} #{neobundle_root}" unless File.exists? neobundle_root
end

desc "Install vim plugins via NeoBundle"
task :vim_plugins => [:vim, :vimrc, 'neobundle.vim'] do
  sh 'vim +NeoBundleCheck +quitall'
end

desc "Take a dotfile from $HOME"
task :take, :dotless_name do |t, args|
  dotless = args[:dotless_name]
  filename = ".#{dotless}"
  full_path = "#{HOME}/#{filename}"
  next unless File.exists? full_path
  if File.symlink? full_path
    puts "#{full_path} is a symlink, not taken."
    next
  end
  mv full_path, dotless
end

desc "Install everything"
task :everything => DOTFILES
task :default => :everything
