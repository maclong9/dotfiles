#!/usr/bin/swift
import Foundation

extension Process {
  private static let gitExecPath = URL(fileURLWithPath: "/usr/bin/git")
  private static let lnExecPath = URL(fileURLWithPath: "/bin/ln")
  private static let shExecPath = URL(fileURLWithPath: "/bin/sh")

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

  public func install(from src: String, withOutput: Bool = false, extraArgs: String? = nil, runAfter: String? = nil) throws {
    executableURL = Process.shExecPath
    arguments = ["-c", "curl -fsSL \(withOutput ? "-o" : "") \(extraArgs ?? "")  \(src) | sh"]
    try run()
    waitUntilExit()

    if let runAfter = runAfter {
      arguments = ["-c", runAfter]
      try run()
      waitUntilExit()
    }
  }
}

func enableTouchIDForSudo() throws {
  let pamFilePath = "/etc/pam.d/sudo"
  let pamTidLine = "auth       sufficient     pam_tid.so\n"
  var pamContents = try String(contentsOfFile: pamFilePath, encoding: .utf8)
  
  if !pamContents.contains(pamTidLine) {
    let lines = pamContents.split(separator: "\n", omittingEmptySubsequences: false)
    pamContents = lines.prefix(1).joined(separator: "\n") + "\n" + pamTidLine + lines.dropFirst().joined(separator: "\n")
    try pamContents.write(toFile: pamFilePath, atomically: true, encoding: .utf8)
  }
}

do {
  let homeDir = "/Users/mac"
  let configPath = "\(homeDir)/.config"

  try enableTouchIDForSudo()

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

  if !FileManager.default.fileExists(atPath: "\(homeDir)/.deno") {
    try Process().install(from: "https://deno.land/install.sh")
  }

  if !FileManager.default.fileExists(atPath: URL(fileURLWithPath: "/usr/local/bin/tmux").path) {
    try Process().install(
      from:
        "https://gist.githubusercontent.com/tomasbasham/1e405cfa16e88c0f5d2f49bbbd161944/raw/c70c143eecadc3ca67317227bbb687f51486353d/install_tmux_osx_no_brew",
      runAfter: "rm -rf \(homeDir)/tmux-install"
    )
  }

  if !FileManager.default.fileExists(atPath: "\(homeDir)/.vim") {
    try Process().install(
      from: "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
      withOutput: true,
      extraArgs: "\(homeDir)/.vim/autoload/plug.vim --create-dirs",
      runAfter: "vim +PlugInstall +qall"
    )
  }  
} catch {
  print("Error: \(error)")
}
