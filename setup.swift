#!/usr/bin/swift
import Foundation

let homeDir = "/Users/mac"
let configPath = "\(homeDir)/.config"
let tmuxVer = "3.4"
let libEventVer = "2.1.12-stable"
let fm = FileManager.default

extension Process {
  public func execute(_ binary: String, with args: [String]? = []) throws {
    executableURL = URL(fileURLWithPath: binary)
    arguments = args
    try run()
    waitUntilExit()
  }

  public func clone(from repo: String, to path: String) throws {
    try execute(
      "/usr/bin/git",
      with: [
        "clone",
        "-q",
        repo.contains("github") ? repo : "https://github.com/\(repo)",
        path,
      ])
  }

  public func link(from src: String, to dest: String) throws {
    try execute("/bin/ln", with: ["-s", src, dest])
  }

  public func gitInstall(from url: String) throws {
    let repoUrl = URL(string: url)!
    try Process().clone(from: repoUrl.path, to: repoUrl.lastPathComponent)
    fm.changeCurrentDirectoryPath(repoUrl.lastPathComponent)
    try execute("/usr/bin/swift", with: ["run", "mint", "install", "yonaskolb/mint"])
    fm.changeCurrentDirectoryPath(homeDir)
    try fm.removeItem(at: URL(fileURLWithPath: repoUrl.lastPathComponent))
  }

  public func scriptInstall(from src: String) throws {
    try execute("/bin/sh", with: ["-c", "curl -fsSL \(src) | sh"])
  }
}

do {
  try Process().clone(from: "maclong9/dotfiles", to: configPath)
  let enumerator = fm.enumerator(
    at: URL(fileURLWithPath: configPath),
    includingPropertiesForKeys: [.isRegularFileKey],
    options: [.skipsHiddenFiles]
  )

  while let fileUrl = enumerator?.nextObject() as? URL {
    if fileUrl.pathExtension.isEmpty || fileUrl.pathExtension.contains("conf") {
      try Process().link(
        from: fileUrl.path,
        to: "\(homeDir)/.\(fileUrl.lastPathComponent)"
      )
    }
  }

  try Process().scriptInstall(from: "https://deno.land/install.sh")
  try Process().gitInstall(from: "https://github.com/yonaskolb/Mint")
  try Process().scriptInstall(from: "https://gist.githubusercontent.com/maclong9/32616842c8197da8271dda426b78f87c/raw/d4698fa97ce39a3134062f44fb59f4c978777a05/install-tmux.sh")
  
} catch {
  print("Error: \(error)")
}
