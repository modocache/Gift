def run(command)
  puts command
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

namespace "dependencies" do
  namespace "build" do
    desc "Build OpenSSL and libssh2 for iOS"
    task :libssh2 do
      run "cd External/libssh2-for-iOS && ./build-all.sh openssl"
      run "cd External/libssh2-for-iOS && git checkout -- . && git clean -fd"
    end
  end
end

