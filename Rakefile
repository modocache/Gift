Dir.glob("Scripts/*.rake").each { |rake_file| load rake_file }

desc "Build libssh2 and libgit2 for iOS and OS X"
task :build => ["build:osx", "build:ios"]

desc "Install all dependencies and build libssh2 and libgit2 for iOS and OS X"
task :default => ["test"]

