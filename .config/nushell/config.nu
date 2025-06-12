let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | from tsv --flexible --noheaders --no-infer
    | rename value description
}

let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

let multiple_completers = {|spans|}

$env.config = {
    completions: {
        external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
        }
    }
}

source ./custom_commands.nu
