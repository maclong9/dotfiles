#!/usr/bin/swift
import Foundation

extension Process {
  private static let gitExecPath = URL(fileURLWithPath: "/usr/bin/git")
  private static let lnExecPath = URL(fileURLWithPath: "/bin/ln")
  private static let shExecPath = URL(fileURLWithPath: "/bin/sh")
  private static let vimExecPath = URL(fileURLWithPath: "/usr/bin/vim")

  public func clone(from repo: String, to path: String) throws {
    executableURL = Process.gitExecPath
    arguments = ["clone", "-q", repo, path]
    try run()
    waitUntilExit()
  }

  public func link(from src: URL, to dest: URL) throws {
    executableURL = Process.lnExecPath
    arguments = ["-s", src.path, dest.path]
    try run()
    waitUntilExit()
  }

  public func install(
    from src: String, withOutput: Bool = false, extraArgs: String? = nil
  ) throws {
    executableURL = Process.shExecPath
    arguments = ["-c", "curl \(withOutput ? "-o" : "") \(extraArgs ?? "")  \(src) | sh"]
    try run()
    waitUntilExit()
  }

  public func vimSetup() throws {
    executableURL = Process.vimExecPath
    arguments = ["+PlugInstall", "+qall"]
    try run()
    waitUntilExit()
  }
}

do {
  let homeDir = "/Users/mac"
  let configPath = "\(homeDir)/.config"

  try Process().clone(
    from: "https://github.com/maclong9/dotfiles",
    to: configPath
  )

  sleep(4)

  let enumerator = FileManager.default.enumerator(
    at: URL(fileURLWithPath: configPath),
    includingPropertiesForKeys: [.isRegularFileKey],
    options: [.skipsHiddenFiles, .skipsPackageDescendants]
  )

  while let fileUrl = enumerator?.nextObject() as? URL {
    if fileUrl.pathExtension != "swift" {
      try Process().link(
        from: fileUrl,
        to: URL(
          fileURLWithPath: "\(homeDir)/.\(fileUrl.lastPathComponent)"
        )
      )
    }
  }

  if !FileManager.default.fileExists(atPath: "/Users/mac/.deno") {
    print("Installing Deno")
    try Process().install(from: "https://deno.land/install.sh")
  }

  if !FileManager.default.fileExists(atPath: URL(fileURLWithPath: "/usr/local/bin/tmux").path) {
    try Process().install(
      from:
        "https://gist.githubusercontent.com/tomasbasham/1e405cfa16e88c0f5d2f49bbbd161944/raw/c70c143eecadc3ca67317227bbb687f51486353d/install_tmux_osx_no_brew"
    )
  }
  try FileManager.default.removeItem(at: URL(fileURLWithPath: "\(homeDir)/tmux-install"))

  if !FileManager.default.fileExists(atPath: "/Users/mac/.vim") {
    try Process().install(
      from: "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
      withOutput: true,
      extraArgs: "/Users/mac/.vim/autoload/plug.vim --create-dirs"
    )
  }
  try Process().vimSetup()

} catch {
  print("Error: \(error)")
}
