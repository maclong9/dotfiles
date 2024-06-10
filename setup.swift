#!/usr/bin/swift
import Foundation

let homeDir = "/Users/mac"
let configPath = "\(homeDir)/.config"
let mintPath = "\(homeDir)/Mint"

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

  func install(from url: URL, install: Bool? = false) throws {
    if !url.path.contains("github") {
      try Process().clone(from: url.path, to: url.lastPathComponent)
    }

    FileManager.default.changeCurrentDirectoryPath(url.lastPathComponent)

    if let install = install, !install {
        try execute("/usr/bin/sudo", with: ["make"])
    }
  }

  func installFromScript(from src: String) throws {
    try execute("/bin/sh", with: ["-c", "curl", "-fsSl", src, "| sh"])
  }
}

do {
  try Process().clone(from: "maclong9/dotfiles", to: configPath)
  let enumerator = FileManager.default.enumerator(
    at: URL(fileURLWithPath: configPath),
    includingPropertiesForKeys: [.isRegularFileKey],
    options: [.skipsHiddenFiles]
  )

  while let fileUrl = enumerator?.nextObject() as? URL {
    if fileUrl.pathExtension.isEmpty {
      try Process().link(
        from: fileUrl.path,
        to: "\(homeDir)/.\(fileUrl.lastPathComponent)"
      )
    }
  }

  try Process().installFromScript(from: "https://deno.land/install.sh")
  try Process().install(from: URL(string: "https://github.com/yonaskolb/Mint")!)
} catch {
  print("Error: \(error)")
}

