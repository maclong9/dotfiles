#!/usr/bin/swift
import Foundation

let homeDir = "/Users/mac"
let configPath = "\(homeDir)/.config"
let mintPath = "\(homeDir)/Mint"

extension Process {
  public func clone(from repo: String, to path: String) throws {
    executableURL = URL(fileURLWithPath: "/usr/bin/git")
    arguments = ["clone", "-q", repo, path]
    try run()
    waitUntilExit()
  }

  public func link(from src: URL, to dest: URL) throws {
    executableURL = URL(fileURLWithPath: "/bin/ln")
    arguments = ["-s", src.path, dest.path]
    try run()
    waitUntilExit()
  }

  func install(from src: String) throws {
    executableURL = URL(fileURLWithPath: "/bin/sh")
    arguments = ["-c", "curl -fsSL \(src) | sh"]
    try run()
    waitUntilExit()
  }

  func runCommand(at path: String? = FileManager.default.currentDirectoryPath, with args: [String]) throws {
    executableURL = URL(fileURLWithPath: "/usr/bin/env")
    arguments = ["sh", "-c", path != nil ? "cd \(path!) && \(args.joined(separator: " "))" : args.joined(separator: " ")]
    try run()
    waitUntilExit()
  }
}

do {
  try Process().clone(from: "https://github.com/maclong9/dotfiles", to: configPath)

  let enumerator = FileManager.default.enumerator(
    at: URL(fileURLWithPath: configPath),
    includingPropertiesForKeys: [.isRegularFileKey],
    options: [.skipsHiddenFiles, .skipsPackageDescendants]
  )

  while let fileUrl = enumerator?.nextObject() as? URL {
    if fileUrl.pathExtension != "swift" && fileUrl.pathExtension != "md" {
      try Process().link(
        from: fileUrl,
        to: URL(fileURLWithPath: "\(homeDir)/.\(fileUrl.lastPathComponent)")
      )
    }
  }

  try Process().install(from: "https://deno.land/install.sh")
  try Process().install(
    from: "https://gist.githubusercontent.com/maclong9/32616842c8197da8271dda426b78f87c/raw/147a8a49194f3cc18ecc58578226996001adef8c/install-tmux.sh"
  )
  try FileManager.default.removeItem(at: URL(fileURLWithPath: "\(homeDir)/tmux-install"))
  try Process().clone(from: "https://github.com/yonaskolb/Mint.git", to: mintPath)
  try Process().runCommand(at: mintPath, with: ["sudo make"])
  try Process().runCommand(with: ["mint install maclong9/SwiftList"])
} catch {
  print("Error: \(error)")
}
