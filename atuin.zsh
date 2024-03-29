#compdef atuin

autoload -U is-at-least

_atuin() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
'-V[Print version information]' \
'--version[Print version information]' \
":: :_atuin_commands" \
"*::: :->atuin" \
&& ret=0
    case $state in
    (atuin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:atuin-command-$line[1]:"
        case $line[1] in
            (history)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
":: :_atuin__history_commands" \
"*::: :->history" \
&& ret=0

    case $state in
    (history)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:atuin-history-command-$line[1]:"
        case $line[1] in
            (start)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::command:' \
&& ret=0
;;
(end)
_arguments "${_arguments_options[@]}" \
'-e+[]:EXIT: ' \
'--exit=[]:EXIT: ' \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
':id:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-c[]' \
'--cwd[]' \
'-s[]' \
'--session[]' \
'--human[]' \
'--cmd-only[Show only the text of the command]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(last)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'--human[]' \
'--cmd-only[Show only the text of the command]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::subcommand -- The subcommand whose help message to display:' \
&& ret=0
;;
        esac
    ;;
esac
;;
(import)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
":: :_atuin__import_commands" \
"*::: :->import" \
&& ret=0

    case $state in
    (import)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:atuin-import-command-$line[1]:"
        case $line[1] in
            (auto)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(zsh)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(bash)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(resh)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(fish)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::subcommand -- The subcommand whose help message to display:' \
&& ret=0
;;
        esac
    ;;
esac
;;
(stats)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
":: :_atuin__stats_commands" \
"*::: :->stats" \
&& ret=0

    case $state in
    (stats)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:atuin-stats-command-$line[1]:"
        case $line[1] in
            (all)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(day)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::words:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::subcommand -- The subcommand whose help message to display:' \
&& ret=0
;;
        esac
    ;;
esac
;;
(init)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
":: :_atuin__init_commands" \
"*::: :->init" \
&& ret=0

    case $state in
    (init)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:atuin-init-command-$line[1]:"
        case $line[1] in
            (zsh)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(bash)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(fish)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::subcommand -- The subcommand whose help message to display:' \
&& ret=0
;;
        esac
    ;;
esac
;;
(uuid)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(search)
_arguments "${_arguments_options[@]}" \
'-c+[Filter search result by directory]:CWD: ' \
'--cwd=[Filter search result by directory]:CWD: ' \
'--exclude-cwd=[Exclude directory from results]:EXCLUDE_CWD: ' \
'-e+[Filter search result by exit code]:EXIT: ' \
'--exit=[Filter search result by exit code]:EXIT: ' \
'--exclude-exit=[Exclude results with this exit code]:EXCLUDE_EXIT: ' \
'-b+[Only include results added before this date]:BEFORE: ' \
'--before=[Only include results added before this date]:BEFORE: ' \
'--after=[Only include results after this date]:AFTER: ' \
'-i[Open interactive search UI]' \
'--interactive[Open interactive search UI]' \
'--human[Use human-readable formatting for time]' \
'--cmd-only[Show only the text of the command]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::query:' \
&& ret=0
;;
(gen-completions)
_arguments "${_arguments_options[@]}" \
'-s+[Set the shell for generating completions]:SHELL: ' \
'--shell=[Set the shell for generating completions]:SHELL: ' \
'-o+[Set the output directory]:OUT_DIR: ' \
'--out-dir=[Set the output directory]:OUT_DIR: ' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" \
'-f[Force re-download everything]' \
'--force[Force re-download everything]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" \
'-u+[]:USERNAME: ' \
'--username=[]:USERNAME: ' \
'-p+[]:PASSWORD: ' \
'--password=[]:PASSWORD: ' \
'-k+[The encryption key for your account]:KEY: ' \
'--key=[The encryption key for your account]:KEY: ' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(register)
_arguments "${_arguments_options[@]}" \
'-u+[]:USERNAME: ' \
'--username=[]:USERNAME: ' \
'-e+[]:EMAIL: ' \
'--email=[]:EMAIL: ' \
'-p+[]:PASSWORD: ' \
'--password=[]:PASSWORD: ' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(key)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(server)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
":: :_atuin__server_commands" \
"*::: :->server" \
&& ret=0

    case $state in
    (server)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:atuin-server-command-$line[1]:"
        case $line[1] in
            (start)
_arguments "${_arguments_options[@]}" \
'--host=[The host address to bind]:HOST: ' \
'-p+[The port to bind]:PORT: ' \
'--port=[The port to bind]:PORT: ' \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'--version[Print version information]' \
'-h[Print help information]' \
'--help[Print help information]' \
'*::subcommand -- The subcommand whose help message to display:' \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
'*::subcommand -- The subcommand whose help message to display:' \
&& ret=0
;;
        esac
    ;;
esac
}

(( $+functions[_atuin_commands] )) ||
_atuin_commands() {
    local commands; commands=(
'history:Manipulate shell history' \
'import:Import shell history from file' \
'stats:Calculate statistics for your history' \
'init:Output shell setup' \
'uuid:Generate a UUID' \
'search:Interactive history search' \
'gen-completions:Generate shell completions' \
'sync:Sync with the configured server' \
'login:Login to the configured server' \
'logout:Log out' \
'register:Register with the configured server' \
'key:Print the encryption key for transfer to another machine' \
'server:Start an atuin server' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'atuin commands' commands "$@"
}
(( $+functions[_atuin__stats__all_commands] )) ||
_atuin__stats__all_commands() {
    local commands; commands=()
    _describe -t commands 'atuin stats all commands' commands "$@"
}
(( $+functions[_atuin__import__auto_commands] )) ||
_atuin__import__auto_commands() {
    local commands; commands=()
    _describe -t commands 'atuin import auto commands' commands "$@"
}
(( $+functions[_atuin__import__bash_commands] )) ||
_atuin__import__bash_commands() {
    local commands; commands=()
    _describe -t commands 'atuin import bash commands' commands "$@"
}
(( $+functions[_atuin__init__bash_commands] )) ||
_atuin__init__bash_commands() {
    local commands; commands=()
    _describe -t commands 'atuin init bash commands' commands "$@"
}
(( $+functions[_atuin__stats__day_commands] )) ||
_atuin__stats__day_commands() {
    local commands; commands=()
    _describe -t commands 'atuin stats day commands' commands "$@"
}
(( $+functions[_atuin__history__end_commands] )) ||
_atuin__history__end_commands() {
    local commands; commands=()
    _describe -t commands 'atuin history end commands' commands "$@"
}
(( $+functions[_atuin__import__fish_commands] )) ||
_atuin__import__fish_commands() {
    local commands; commands=()
    _describe -t commands 'atuin import fish commands' commands "$@"
}
(( $+functions[_atuin__init__fish_commands] )) ||
_atuin__init__fish_commands() {
    local commands; commands=()
    _describe -t commands 'atuin init fish commands' commands "$@"
}
(( $+functions[_atuin__gen-completions_commands] )) ||
_atuin__gen-completions_commands() {
    local commands; commands=()
    _describe -t commands 'atuin gen-completions commands' commands "$@"
}
(( $+functions[_atuin__help_commands] )) ||
_atuin__help_commands() {
    local commands; commands=()
    _describe -t commands 'atuin help commands' commands "$@"
}
(( $+functions[_atuin__history__help_commands] )) ||
_atuin__history__help_commands() {
    local commands; commands=()
    _describe -t commands 'atuin history help commands' commands "$@"
}
(( $+functions[_atuin__import__help_commands] )) ||
_atuin__import__help_commands() {
    local commands; commands=()
    _describe -t commands 'atuin import help commands' commands "$@"
}
(( $+functions[_atuin__init__help_commands] )) ||
_atuin__init__help_commands() {
    local commands; commands=()
    _describe -t commands 'atuin init help commands' commands "$@"
}
(( $+functions[_atuin__server__help_commands] )) ||
_atuin__server__help_commands() {
    local commands; commands=()
    _describe -t commands 'atuin server help commands' commands "$@"
}
(( $+functions[_atuin__stats__help_commands] )) ||
_atuin__stats__help_commands() {
    local commands; commands=()
    _describe -t commands 'atuin stats help commands' commands "$@"
}
(( $+functions[_atuin__history_commands] )) ||
_atuin__history_commands() {
    local commands; commands=(
'start:Begins a new command in the history' \
'end:Finishes a new command in the history (adds time, exit code)' \
'list:List all items in history' \
'last:Get the last command ran' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'atuin history commands' commands "$@"
}
(( $+functions[_atuin__import_commands] )) ||
_atuin__import_commands() {
    local commands; commands=(
'auto:Import history for the current shell' \
'zsh:Import history from the zsh history file' \
'bash:Import history from the bash history file' \
'resh:Import history from the resh history file' \
'fish:Import history from the fish history file' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'atuin import commands' commands "$@"
}
(( $+functions[_atuin__init_commands] )) ||
_atuin__init_commands() {
    local commands; commands=(
'zsh:Zsh setup' \
'bash:Bash setup' \
'fish:Fish setup' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'atuin init commands' commands "$@"
}
(( $+functions[_atuin__key_commands] )) ||
_atuin__key_commands() {
    local commands; commands=()
    _describe -t commands 'atuin key commands' commands "$@"
}
(( $+functions[_atuin__history__last_commands] )) ||
_atuin__history__last_commands() {
    local commands; commands=()
    _describe -t commands 'atuin history last commands' commands "$@"
}
(( $+functions[_atuin__history__list_commands] )) ||
_atuin__history__list_commands() {
    local commands; commands=()
    _describe -t commands 'atuin history list commands' commands "$@"
}
(( $+functions[_atuin__login_commands] )) ||
_atuin__login_commands() {
    local commands; commands=()
    _describe -t commands 'atuin login commands' commands "$@"
}
(( $+functions[_atuin__logout_commands] )) ||
_atuin__logout_commands() {
    local commands; commands=()
    _describe -t commands 'atuin logout commands' commands "$@"
}
(( $+functions[_atuin__register_commands] )) ||
_atuin__register_commands() {
    local commands; commands=()
    _describe -t commands 'atuin register commands' commands "$@"
}
(( $+functions[_atuin__import__resh_commands] )) ||
_atuin__import__resh_commands() {
    local commands; commands=()
    _describe -t commands 'atuin import resh commands' commands "$@"
}
(( $+functions[_atuin__search_commands] )) ||
_atuin__search_commands() {
    local commands; commands=()
    _describe -t commands 'atuin search commands' commands "$@"
}
(( $+functions[_atuin__server_commands] )) ||
_atuin__server_commands() {
    local commands; commands=(
'start:Start the server' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'atuin server commands' commands "$@"
}
(( $+functions[_atuin__history__start_commands] )) ||
_atuin__history__start_commands() {
    local commands; commands=()
    _describe -t commands 'atuin history start commands' commands "$@"
}
(( $+functions[_atuin__server__start_commands] )) ||
_atuin__server__start_commands() {
    local commands; commands=()
    _describe -t commands 'atuin server start commands' commands "$@"
}
(( $+functions[_atuin__stats_commands] )) ||
_atuin__stats_commands() {
    local commands; commands=(
'all:Compute statistics for all of time' \
'day:Compute statistics for a single day' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'atuin stats commands' commands "$@"
}
(( $+functions[_atuin__sync_commands] )) ||
_atuin__sync_commands() {
    local commands; commands=()
    _describe -t commands 'atuin sync commands' commands "$@"
}
(( $+functions[_atuin__uuid_commands] )) ||
_atuin__uuid_commands() {
    local commands; commands=()
    _describe -t commands 'atuin uuid commands' commands "$@"
}
(( $+functions[_atuin__import__zsh_commands] )) ||
_atuin__import__zsh_commands() {
    local commands; commands=()
    _describe -t commands 'atuin import zsh commands' commands "$@"
}
(( $+functions[_atuin__init__zsh_commands] )) ||
_atuin__init__zsh_commands() {
    local commands; commands=()
    _describe -t commands 'atuin init zsh commands' commands "$@"
}

_atuin "$@"
