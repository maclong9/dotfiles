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
      with: ["clone", "-q", "https://github.com/\(repo)", path])
  }
}

func symbolicallyLinkFiles() throws {
  let enumerator = fm.enumerator(
    at: URL(fileURLWithPath: configPath),
    includingPropertiesForKeys: [.isRegularFileKey],
    options: [.skipsHiddenFiles]
  )

  while let fileUrl = enumerator?.nextObject() as? URL {
    if fileUrl.pathExtension.isEmpty {
      try execute("/bin/ln", with: [
        "-s",
        fileUrl.path,
        "\(homeDir)/.\(fileUrl.lastPathComponent)"
      ])
    }
  }
}

do {
  try Process().clone(from: "maclong9/dotfiles", to: configPath)
  try execute("/bin/sh", with: ["-c", "curl -fsSL https://deno.land/install.sh | sh"])
  try symbolicallyLinkFiles()
} catch {
  print("Error: \(error)")
}
