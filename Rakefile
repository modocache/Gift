def run(command)
  puts command
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

def sdk_root(arch)
  if %w(x86_64 i386).include? arch
    platform = "iphonesimulator"
  else
    platform = "iphoneos"
  end
  `xcodebuild -version -sdk 2> /dev/null | grep -i #{platform}8.2 | grep 'Path:' | awk '{ print $2 }'`.strip
end

namespace "build" do
  namespace "ios" do
    desc "Build OpenSSL and libssh2 for iOS"
    task :libssh2 do
      run "cd External/libssh2-for-iOS && ./build-all.sh openssl"
      run "cd External/libssh2-for-iOS && git checkout -- . && git clean -fd"
    end

    desc "Build libgit2 for iOS"
    task :libgit2 do
      root_path = `pwd`.strip
      xcode_path = `xcode-select --print-path`.strip

      %w(x86_64 i386 armv7 armv7s arm64).each do |arch|
        run "rm -rf External/libgit2/build"
        run "mkdir External/libgit2/build"

        install_prefix = "#{root_path}/External/libgit2-iOS/#{arch}"
        run "mkdir -p #{install_prefix}"

        run <<-command
          cd External/libgit2/build && \\
          export IPHONEOS_DEPLOYMENT_TARGET=8.0 && \\
          export SDKROOT=#{xcode_path}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.2.sdk && \\
          /usr/local/bin/cmake \\
                -DCMAKE_C_COMPILER=clang \\
                -DCMAKE_C_COMPILER_WORKS:BOOL=ON \\
                -DBUILD_SHARED_LIBS:BOOL=OFF \\
                -DOPENSSL_INCLUDE_DIR:PATH=#{root_path}/External/libssh2-for-iOS/include/ \\
                -DCMAKE_LIBRARY_PATH:PATH=#{root_path}/External/libssh2-for-iOS/lib/ \\
                -DCMAKE_INCLUDE_PATH:PATH=#{root_path}/External/libssh2-for-iOS/include/libssh2/ \\
                -DOPENSSL_SSL_LIBRARY:FILEPATH=#{root_path}/External/libssh2-for-iOS/lib/libssl.a \\
                -DCMAKE_LIBRARY_PATH:PATH="#{sdk_root(arch)}/usr/lib/" \\
                -DOPENSSL_CRYPTO_LIBRARY:FILEPATH=#{root_path}/External/libssh2-for-iOS/lib/libcrypto.a \\
                -DCMAKE_INSTALL_PREFIX:PATH="#{install_prefix}" \\
                -DBUILD_CLAR:BOOL=OFF \\
                -DTHREADSAFE:BOOL=ON \\
                #{"-DCMAKE_OSX_SYSROOT=#{sdk_root(arch)}" unless %w(x86_64 i386).include? arch} \\
                -DCMAKE_OSX_ARCHITECTURES:STRING="#{arch}" \\
                ..
        command
        run "cd External/libgit2/build && cmake --build . --target install"
      end

      run <<-command
        lipo -create \\
          External/libgit2-iOS/x86_64/lib/libgit2.a \\
          External/libgit2-iOS/i386/lib/libgit2.a \\
          External/libgit2-iOS/armv7/lib/libgit2.a \\
          External/libgit2-iOS/armv7s/lib/libgit2.a \\
          External/libgit2-iOS/arm64/lib/libgit2.a \\
          -output External/libgit2-iOS/libgit2-iOS.a
      command
    end
  end
end

