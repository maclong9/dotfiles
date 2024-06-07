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
  }

  public func link(from src: URL, to dest: URL) throws {
    executableURL = Process.lnExecPath
    arguments = ["-s", src.path, dest.path]
    try run()
  }

  public func install(
    from src: String,
    withOutput: Bool = false,
    extraArgs: String? = nil
  ) throws {
    executableURL = Process.shExecPath
    arguments = ["-c", "curl \(withOutput ? "-o" : "") \(extraArgs ?? "")  \(src) | sh"]
    try run()
  }
}

do {
  let configPath = "/Users/mac/.config"

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
          fileURLWithPath: "/Users/mac/.\(fileUrl.lastPathComponent)"
        )
      )
    }
  }

  if !FileManager.default.fileExists(atPath: "/Users/mac/.deno") {
    try Process().install(from: "https://deno.land/install.sh")
  }

  if !FileManager.default.fileExists(atPath: "/Users/mac/.vim") {
    try Process().install(
      from: "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
      withOutput: true,
      extraArgs: "/Users/mac/.vimrc/autoload/plug.vim --create-dirs"
    )
  }

  exit(0)
} catch {
  print("Error: \(error)")
}
