#!/usr/bin/swift
import Foundation

let homeDir = "/Users/mac"
let configPath = "\(homeDir)/.config"

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

  public func installTooling() throws {
    try Process().install(from: "https://deno.land/install.sh")
    try Process().install(
      from:
        "https://gist.githubusercontent.com/maclong9/32616842c8197da8271dda426b78f87c/raw/147a8a49194f3cc18ecc58578226996001adef8c/install-tmux.sh"
    )
    try FileManager.default.removeItem(at: URL(fileURLWithPath: "\(homeDir)/tmux-install"))
  }

   public func installSwiftList() throws {
        let url = URL(string: "https://github.com/maclong9/SwiftList/releases/download/v1.0.2/sls")!
        let destination = URL(fileURLWithPath: "/usr/local/bin/sls")
        
        let downloadTask = URLSession.shared.downloadTask(with: url) { location, _, error in
            guard let location = location, error == nil else {
                print("Error downloading SwiftList binary: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                try FileManager.default.moveItem(at: location, to: destination)
                print("SwiftList installed successfully to /usr/local/bin")
            } catch {
                print("Error moving SwiftList binary to /usr/local/bin: \(error.localizedDescription)")
            }
        }
        downloadTask.resume()
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

  try Process().installTooling()
  try Process().installSwiftList()
} catch {
  print("Error: \(error)")
}
