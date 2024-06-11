#!/usr/bin/swift
import Foundation

let homeDir = "/Users/mac"
let configPath = "\(homeDir)/.config"
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
    try Process().execute(
        "/usr/bin/git",
        with: [
            "clone",
            "-q",
            "https://github.com/maclong9/dotfiles",
            configPath
        ]
    )
    
    try Process().execute(
        "/bin/sh",
        with: [
            "-c",
            "curl -fsSL https://deno.land/install.sh | sh"
        ]
    )

    let enumerator = fm.enumerator(
        at: URL(fileURLWithPath: configPath),
        includingPropertiesForKeys: [.isRegularFileKey],
        options: [.skipsHiddenFiles]
    )

    while let fileUrl = enumerator?.nextObject() as? URL {
        if fileUrl.pathExtension.isEmpty {
            try Process().execute(
                "/bin/ln",
                with: [
                    "-s",
                    fileUrl.path,
                    "\(homeDir)/.\(fileUrl.lastPathComponent)",
                ]
            )
        }
    }
} catch {
    print("Error: \(error)")
}
