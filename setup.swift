#!/usr/bin/swift
import Foundation

let homeDir = "/Users/mac"
let configPath = "\(homeDir)/.config"
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

  public func install(from src: String) throws {
    try execute("/bin/sh", with: ["-c", "curl -fsSL \(src) | sh"])
  }
}

func symbolicallyLinkFiles() throws {
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
}

do {
  try Process().clone(from: "maclong9/dotfiles", to: configPath)
  try Process().install(from: "https://deno.land/install.sh")
  try symbolicallyLinkFiles()

} catch {
  print("Error: \(error)")
}
