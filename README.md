OS自作入門
===

## macOSでのセットアップ

```bash
xcode-select --install
softwareupdate --install-rosetta --agree-to-license
arch -arch x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install nasm mtools
arch -arch x86_64 /usr/local/bin/brew tap nativeos/i386-elf-toolchain
arch -arch x86_64 /usr/local/bin/brew install i386-elf-binutils i386-elf-gcc
```

## リファレンスページ
* 書籍上の、http://community.osdev.info/  はなくなっていて、http://oswiki.osask.jp/ で同じpathで利用できる
	* http://oswiki.osask.jp/
