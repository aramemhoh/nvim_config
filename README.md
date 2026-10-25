# Neovim Java / Spring Boot IDE — macOS (Apple Silicon)

This is a **separate Neovim profile**, so your `~/.config/nvim` is not affected.

## 1. Prerequisites

```sh
brew install neovim openjdk@21 git ripgrep fd tree-sitter-cli
```

For Apple Silicon Homebrew, add to `~/.zshrc` if Java 21 is not already discoverable:

```sh
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

Open a new shell. Check versions:

```sh
nvim --version | head -1  # Neovim >= 0.12
java -version             # Java 21 to run language tools
command -v tree-sitter    # parser CLI
```

Your project can use another JDK/Java language level. nvim-java automatically downloads the supported JDTLS/debug/test/Spring tooling via its own installer. The first project open requires an internet connection.

## 2. Install isolated profile

From the folder containing `install.sh`:

```sh
./install.sh
```

This copies only into `~/.config/nvim-spring-ide` and fails safely if the directory exists.

## 3. Start in the ROOT of a Gradle repository

```sh
cd /path/to/repository      # directory with settings.gradle[.kts], gradlew
NVIM_APPNAME=nvim-spring-ide nvim .
```

On the first launch, `lazy.nvim` clones plugins. Wait for completion; restart Neovim once. On first opening a `.java` file, JDTLS may download tools and index the whole project. Open an actual Java file inside the repository; the file explorer alone doesn't start the Java LSP.

Check `:Lazy`, `:Mason`, `:checkhealth vim.lsp`, `:LspInfo` (if available), or run `:lua =vim.lsp.get_clients({bufnr=0})` for running clients.

## Keybindings

`<leader>` = Space. Keys are shown literally: `Space f f` means press Space, f, f.

| Keys | Action |
| --- | --- |
| Space f f | Search files |
| Space f g | Grep repository text |
| Space f b | Buffers |
| Space e | File explorer |
| `gd` / `gr` / `gi` | Definition / references / implementation |
| `K` | Hover docs |
| Space r n | Rename symbol |
| Space c a | Code action |
| Space s b | Spring beans via `@+` symbols |
| Space s e | REST endpoints via `@/` symbols |
| Space j t | Run JUnit method under cursor |
| Space j c | Run JUnit class |
| Space j d | Debug JUnit method |
| Space j m | Extract Java method |
| Space j r | Run Java main class |
| Space g b | `./gradlew build` |
| Space g t | `./gradlew test` |
| Space g g | Prompt for a Gradle task, e.g. `:api:bootRun` |
| F9 / F5 | Toggle breakpoint / debug continue |
| F10 / F11 | Step over / into |
| Space d u | DAP UI |
| Space x x | Trouble diagnostics |

Gradle commands run from Neovim's current working directory. For multi-project builds, launch at the repo root. Example for module tests in the prompt (`Space g g`): `:some-module:test`.

## Spring troubleshooting

The `nvim-java` plugin pins a tested commit of `spring-boot.nvim` (do not separately upgrade it in this profile without testing). The Spring-specific search uses LSP workspace symbols `@+` for beans and `@/` for request mappings. They require Spring tooling to be attached and indexing to finish; exact results depend on the project. Use `:checkhealth vim.lsp` and check active clients if nothing is returned.

Unlike IntelliJ IDEA Ultimate, advanced understanding of dynamic `IntegrationFlow` routing and full runtime Spring context introspection is limited.

## Important caveat

The Lua config files were prepared against current public documentation. They have not been executed on your macOS machine; if plugin setup or downloads fail, check `:messages`, `:Lazy` and the LSP health report. The `nvim-java` project pins Spring plugin compatibility itself.

## Remove this profile

```sh
rm -rf ~/.config/nvim-spring-ide ~/.local/share/nvim-spring-ide ~/.local/state/nvim-spring-ide ~/.cache/nvim-spring-ide
```

**Do not run the above if you have started using this profile for your own modifications without backing them up.**
