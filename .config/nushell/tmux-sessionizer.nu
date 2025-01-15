def get_tmux [] {
    ps |
    where name == tmux |
    get --ignore-errors pid.0 |
    default null
}

export def get-project-dirs [] {
    let out = ($env.PROJECT_DIRS |
        each {||
            let p = $in;
            $in |
            path expand |
            ls $in |
            where type == dir
            | get name
            | each {||
                $'($p)/($in | path relative-to $p)'
            }
        } | flatten) ++ ($env.CUSTOM_DIRS)
    return $out
}

def get-sessions [] {
    tmux list-sessions |
    str replace --all ":" "" |
    detect columns --no-headers |
    get column0
}

export def tmux-attach [] {
    let selected_session = get-sessions |
        str join "\n" |
        fzf |
        into string |
        str trim

    if "tmux" in $env.TERM {
        tmux switch-client -t $selected_session
        return
    }

    tmux attach -t $selected_session
}

export def main [custom?: path] {
    let selected_project = match $custom {
        null => {
            let selected_project = get-project-dirs |
            str join "\n" |
            fzf --height 40% --border sharp |
            into string |
            str trim

            if $selected_project == "" {
                return
            }

            $selected_project
        }
        _ => $custom
        
    }

    let in_tmux_session = "tmux" in $env.TERM

    let selected_name = $selected_project | path basename

    if (get_tmux) == null {
        tmux new-session -s $selected_name -c ($selected_project | path expand)
        return
    }
    if (tmux has-session -t=($selected_name) | complete | get exit_code | into bool) {
        tmux new-session -ds $selected_name -c ($selected_project | path expand)
    }

    if ($in_tmux_session) {
        tmux switch-client -t $selected_name
        return
    }

    tmux attach -t $selected_name
}
