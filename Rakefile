def run(command)
  puts command
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

namespace "dependencies" do
  namespace "clean" do
    desc "Remove OpenSSL for iOS build products"
    task :openssl do
      run "rm -rf External/ios-openssl/include"
      run "rm -rf External/ios-openssl/lib"
    end
  end

  namespace "build" do
    desc "Build OpenSSL as a static library for iOS"
    task :openssl do
      xcode_path = `xcode-select --print-path`.strip
      sdk_version = "8.2"

      # x84_64
      run "rm -rf /tmp/openssl"
      run "cp -r External/openssl /tmp/"
      run "cd /tmp/openssl && ./Configure BSD-generic64 no-gost no-asm enable-ec_nistp_64_gcc_128 --openssldir=\"/tmp/openssl-x86_64\""
      run "cd /tmp/openssl && perl -i -pe \"s|^CC= gcc|CC= /usr/bin/xcrun clang -miphoneos-version-min=6.0 -arch x86_64 |g\" Makefile"
      run "cd /tmp/openssl && perl -i -pe \"s|^CFLAG= (.*)|CFLAG= -isysroot #{xcode_path}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{sdk_version}.sdk \$1|g\" Makefile"
      run "cd /tmp/openssl && make"
      run "cd /tmp/openssl && make install_sw"

      # arm64
      run "rm -rf /tmp/openssl"
      run "cp -r External/openssl /tmp/"
      run "cd /tmp/openssl && ./Configure BSD-generic64 no-gost no-asm enable-ec_nistp_64_gcc_128 --openssldir=\"/tmp/openssl-arm64\""
      run "cd /tmp/openssl && perl -i -pe \"s|^CC= gcc|CC= /usr/bin/xcrun clang -miphoneos-version-min=6.0 -arch arm64 |g\" Makefile"
      run "cd /tmp/openssl && perl -i -pe \"s|^CFLAG= (.*)|CFLAG= -isysroot #{xcode_path}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS#{sdk_version}.sdk \$1|g\" Makefile"
      run "cd /tmp/openssl && make"
      run "cd /tmp/openssl && make install_sw"

      # i386
      run "rm -rf /tmp/openssl"
      run "cp -r External/openssl /tmp/"
      run "cd /tmp/openssl && ./Configure BSD-generic32 no-gost no-asm --openssldir=\"/tmp/openssl-i386\""
      run "cd /tmp/openssl && perl -i -pe 's|static volatile sig_atomic_t intr_signal|static volatile int intr_signal|' crypto/ui/ui_openssl.c"
      run "cd /tmp/openssl && perl -i -pe \"s|^CC= gcc|CC= /usr/bin/xcrun clang -miphoneos-version-min=6.0 -arch i386 |g\" Makefile"
      run "cd /tmp/openssl && perl -i -pe \"s|^CFLAG= (.*)|CFLAG= -isysroot #{xcode_path}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{sdk_version}.sdk \$1|g\" Makefile"
      run "cd /tmp/openssl && make"
      run "cd /tmp/openssl && make install_sw"

      # armv7
      run "rm -rf /tmp/openssl"
      run "cp -r External/openssl /tmp/"
      run "cd /tmp/openssl && ./Configure BSD-generic32 no-gost no-asm --openssldir=\"/tmp/openssl-armv7\""
      run "cd /tmp/openssl && perl -i -pe 's|static volatile sig_atomic_t intr_signal|static volatile int intr_signal|' crypto/ui/ui_openssl.c"
      run "cd /tmp/openssl && perl -i -pe \"s|^CC= gcc|CC= /usr/bin/xcrun clang -miphoneos-version-min=6.0 -arch armv7 |g\" Makefile"
      run "cd /tmp/openssl && perl -i -pe \"s|^CFLAG= (.*)|CFLAG= -isysroot #{xcode_path}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS#{sdk_version}.sdk \$1|g\" Makefile"
      run "cd /tmp/openssl && make"
      run "cd /tmp/openssl && make install_sw"

      # armv7s
      run "rm -rf /tmp/openssl"
      run "cp -r External/openssl /tmp/"
      run "cd /tmp/openssl && ./Configure BSD-generic32 no-gost no-asm --openssldir=\"/tmp/openssl-armv7s\""
      run "cd /tmp/openssl && perl -i -pe 's|static volatile sig_atomic_t intr_signal|static volatile int intr_signal|' crypto/ui/ui_openssl.c"
      run "cd /tmp/openssl && perl -i -pe \"s|^CC= gcc|CC= /usr/bin/xcrun clang -miphoneos-version-min=6.0 -arch armv7s |g\" Makefile"
      run "cd /tmp/openssl && perl -i -pe \"s|^CFLAG= (.*)|CFLAG= -isysroot #{xcode_path}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS#{sdk_version}.sdk \$1|g\" Makefile"
      run "cd /tmp/openssl && make"
      run "cd /tmp/openssl && make install_sw"

      # Create fat binary...
      run "mkdir -p External/openssl-iOS/include"
      run "cp -r /tmp/openssl-i386/include/openssl External/openssl-iOS/include/"
      run "mkdir -p External/openssl-iOS/lib"
      # ...for libcrypto
      run "lipo -create /tmp/openssl-x86_64/lib/libcrypto.a /tmp/openssl-arm64/lib/libcrypto.a /tmp/openssl-i386/lib/libcrypto.a /tmp/openssl-armv7/lib/libcrypto.a /tmp/openssl-armv7s/lib/libcrypto.a -output External/openssl-iOS/lib/libcrypto.a"
      # ...and libssl
      run "lipo -create /tmp/openssl-x86_64/lib/libssl.a /tmp/openssl-arm64/lib/libssl.a /tmp/openssl-i386/lib/libssl.a /tmp/openssl-armv7/lib/libssl.a /tmp/openssl-armv7s/lib/libssl.a -output External/openssl-iOS/lib/libssl.a"
    end
  end
end
