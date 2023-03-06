./configure --enable-cross-compile --arch=arm --target-os=darwin --cc='clang -arch arm64' --sysroot=$(xcrun --sdk iphoneos --show-sdk-path) --cpu=armv8 --enable-pic
