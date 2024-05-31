#!/usr/bin/swift
import Foundation

extension Process {
  private static let gitExecPath = URL(fileURLWithPath: "/usr/bin/git")
  private static let lnExecPath = URL(fileURLWithPath: "/bin/ln")

  public func clone(repo: String, path: String) throws {
    executableURL = Process.gitExecPath
    arguments = ["clone", "-q", repo, path]
    try run()
  }

  public func link(src: URL, dest: URL) throws {
    executableURL = Process.lnExecPath
    arguments = ["-s", src.path, dest.path]
    try run()
  }
}

do {
  let configPath = "/Users/mac/.config"

  try Process().clone(
    repo: "https://github.com/maclong9/dotfiles",
    path: configPath
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
        src: fileUrl,
        dest: URL(
          fileURLWithPath: "/Users/mac/.\(fileUrl.lastPathComponent)"
        )
      )
    }
  }
} catch {
  print("Error: \(error)")
}
