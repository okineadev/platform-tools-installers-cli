# platform-tools-installers-cli

🚀 It is a command-line scripts designed to quickly install [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools) (ADB, Fastboot) via PowerShell on Windows and other OS's.

## 📦 Supported Platforms

| <div><img src="https://github.com/okineadev/dotload/assets/81070564/99544c04-51e7-41b5-95f7-0828cfc97617" alt="Windows logo" width="30"/></div> **Windows** | <div><img src="https://github.com/okineadev/dotload/raw/main/public/macos-light-logo.svg#gh-light-mode-only" alt="macOS logo" width="30"/><img src="https://github.com/okineadev/dotload/raw/main/public/macos-light-logo.svg#gh-dark-mode-only" alt="macOS logo" width="30"/></div> **macOS** | <div><img src="https://upload.wikimedia.org/wikipedia/commons/f/f1/Icons8_flat_linux.svg" alt="Linux logo" width="30"/></div> **Linux** |
| :-: | :-: | :-: |
| ✅ | ❌ | ❌ |

## 🛠️ Installation (Windows)

To install Android SDK Platform Tools (ADB, Fastboot) on Windows, simply run the following command in PowerShell:

```powershell
powershell -c "irm https://raw.githubusercontent.com/okineadev/platform-tools-installers-cli/main/windows.ps1 | iex"
```

This command downloads and executes the PowerShell script, which automatically installs the required tools from the [original Google package](https://dl.google.com/android/repository/platform-tools-latest-windows.zip).

## 🤔 How does it work?

1. The script first asks for agreement to the [Android SDK Platform-Tools Terms and Conditions](https://developer.android.com/studio/terms)
2. After your consent, the script downloads the archive with these tools, which is available at the link <https://dl.google.com/android/repository/platform-tools-latest-windows.zip> (the file name may be different depending on your operating system, in this case the archive for Windows)
3. The archive is unpacked into the folder `C:\platform-tools` (soon it will be possible to choose the folder for installation)
4. This folder is then added to the user's `Path` environment variable so that you can use these tools from the terminal regardless of which folder you are in (Read [https://en.wikipedia.org/wiki/PATH_(variable)](https://en.wikipedia.org/wiki/PATH_(variable)#DOS,_OS/2,_and_Windows:~:text=When%20a%20command%20is,locations%2C%20or%20invalid%20locations.))

## 🚀 Usage

After installation, you need to restart the computer, after which you can use `adb` and `fastboot` commands from your terminal:

```bash
adb --version
fastboot --version
```

These commands will output the installed versions of the respective tools.

## 🧑‍💻 Contributing

Feel free to open a [pull request](https://github.com/okineadev/platform-tools-installers-cli/pulls) or [issue](https://github.com/okineadev/platform-tools-installers-cli/issues) if you have any suggestions, improvements, or bug reports.

## 📜 License

This project is licensed under the [MIT License](https://github.com/okineadev/platform-tools-installers-cli/blob/main/LICENSE).
