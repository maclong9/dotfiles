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

    public func install(from src: String, withOutput: Bool = false, extraArgs: String? = nil) throws {
        executableURL = URL(fileURLWithPath: "/bin/sh")
        arguments = ["-c", "curl \(withOutput ? "-o" : "") \(extraArgs ?? "")  \(src) | sh"]
        try run()
        waitUntilExit()
    }

  public func installTmux() throws {
    let tmuxInstallDir = "\(homeDir)/tmux-install"
    
    try FileManager.default.createDirectory(atPath: tmuxInstallDir, withIntermediateDirectories: true, attributes: nil)
    currentDirectoryPath = tmuxInstallDir
    
    executableURL = URL(fileURLWithPath: "/usr/bin/curl")
    arguments = ["-OL", "https://www.openssl.org/source/openssl-1.0.2l.tar.gz"]
    try run()
    waitUntilExit()
    
    executableURL = URL(fileURLWithPath: "/usr/bin/curl")
    arguments = ["-OL", "https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz"]
    try run()
    waitUntilExit()
    
    executableURL = URL(fileURLWithPath: "/usr/bin/curl")
    arguments = ["-OL", "https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz"]
    try run()
    waitUntilExit()
    
    executableURL = URL(fileURLWithPath: "/usr/bin/tar")
    arguments = ["xzf", "openssl-1.0.2l.tar.gz"]
    try run()
    waitUntilExit()
    
    arguments = ["xzf", "tmux-2.3.tar.gz"]
    try run()
    waitUntilExit()
    
    arguments = ["xzf", "libevent-2.0.22-stable.tar.gz"]
    try run()
    waitUntilExit()
      
    executableURL = URL(fileURLWithPath: "/bin/sh")
    currentDirectoryPath = "/Users/mac/tmux-install/openssl-1.0.2l"
    arguments = ["-c", "./Configure darwin64-x86_64-cc --prefix=/usr/local --openssldir=/usr/local/ssl && make && sudo make install"]
    try run()
    waitUntilExit()

    currentDirectoryPath = "/Users/mac/tmux-install/libevent-2.0.22-stable"
    arguments = ["-c", "./configure && make && sudo make install"]
    try run()
    waitUntilExit()

    currentDirectoryPath = "/Users/mac/tmux-install/tmux-2.3"
    arguments = ["-c", "LDFLAGS=\"-L/usr/local/lib\" CPPFLAGS=\"-I/usr/local/include\" LIBS=\"-lresolv\" ./configure --prefix=/usr/local && make && sudo make install"]
    try run()
    waitUntilExit()

    try FileManager.default.removeItem(at: URL(fileURLWithPath: "\(homeDir)/tmux-install"))
  }
}

do {
    try Process().clone(from: "https://github.com/maclong9/dotfiles", to: configPath)

    sleep(4)

    let enumerator = FileManager.default.enumerator(
        at: URL(fileURLWithPath: configPath),
        includingPropertiesForKeys: [.isRegularFileKey],
        options: [.skipsHiddenFiles, .skipsPackageDescendants]
    )

    while let fileUrl = enumerator?.nextObject() as? URL {
        if fileUrl.pathExtension != "swift" || fileUrl.pathExtension != "md" {
            try Process().link(
                from: fileUrl,
                to: URL(fileURLWithPath: "\(homeDir)/.\(fileUrl.lastPathComponent)")
            )
        }
    }

    if !FileManager.default.fileExists(atPath: "/Users/mac/.deno") {
        try Process().install(from: "https://deno.land/install.sh")
    }

  try Process().installTmux()

} catch {
    print("Error: \(error)")
}
