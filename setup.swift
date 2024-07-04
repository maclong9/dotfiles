#!/usr/bin/swift
import Foundation

// TODO: Add Homebrew Installation and Tooling Install
// `brew install node deno typescript-language-server`
// `brew install --cask maccy`

let homeDir = "/Users/maclong"
let configPath = "\(homeDir)/.config"
let configRepo = "git@github.com:maclong9/dotfiles.git"
let fm = FileManager.default

extension Process {
    public func execute(_ binary: String, with args: [String]) throws {
        executableURL = URL(fileURLWithPath: binary)
        arguments = args
        try run()
        waitUntilExit()
    }
}

do {
    try Process().execute("/usr/bin/git", with: [
        "clone", "-q", configRepo, configPath
    ])

    let enumerator = fm.enumerator(
        at: URL(fileURLWithPath: configPath),
        includingPropertiesForKeys: [.isRegularFileKey],
        options: [.skipsHiddenFiles]
    )

    while let fileUrl = enumerator?.nextObject() as? URL {
        if fileUrl.pathExtension.isEmpty {
            try Process().execute("/bin/ln", with: ["-s", fileUrl.path, "\(homeDir)/.\(fileUrl.lastPathComponent)"])
        }
    }
} catch {
    print("Error: \(error)")
}
