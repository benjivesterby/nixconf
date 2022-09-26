{ pkgs }:
{
  enable = true;
  defaultKeymap = "viins";
  shellAliases = {
    v = "nvim";
    vim = "nvim";
    sudov = "sudo -E -s nvim";

    l = "exa --long --all";
    lt = "exa --long --all --sort newest";
    ls = "exa";
    tree = "exa --tree --long";

    gd = "go doc";
    gdu = "go doc -u";

    hm = "home-manager";
    tmux = "tmux -2";
    gitlines = "git ls-files | xargs wc -l";
    ack = "ag --ignore-dir=node_modules --ignore-dir=labs --ignore-dir=docs --ignore-dir=dist --ignore-dir=code-coverage-report";
  };
  profileExtra = ''
    if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
  '';
  sessionVariables = {
    KEYTIMEOUT = 1;
    EDITOR = "nvim";
    #XDG_RUNTIME_DIR="/run/user/$(id -u)"; # https://github.com/Trundle/NixOS-WSL/issues/18
  };
  initExtraBeforeCompInit = ''
    '';
  initExtra = ''
    ### Paste utils and auto escaping URLs
    autoload -Uz bracketed-paste-magic
    zle -N bracketed-paste bracketed-paste-magic
    autoload -Uz url-quote-magic
    zle -N self-insert url-quote-magic

    ### Completion menu with colors
    zstyle ':completion:*' menu select
    zstyle ':completion:*default' list-colors ''${(s.:.)LSCOLORS}

    ### Press 'V' in vi mode to open current command in vim
    autoload -U edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd V edit-command-line

    # shortcuts for spitting out an svg from .dot; TODO see about moving this
    # into a derivation around graphviz
    function svg {
          dot -Tsvg $1 -o $1.svg
    }

    # shellcheck disable=SC2034,SC2153,SC2086,SC2155
    
    # Above line is because shellcheck doesn't support zsh, per
    # https://github.com/koalaman/shellcheck/wiki/SC1071, and the ignore: param in
    # ludeeus/action-shellcheck only supports _directories_, not _files_. So
    # instead, we manually add any error the shellcheck step finds in the file to
    # the above line ...
    
    # Source this in your ~/.zshrc
    autoload -U add-zsh-hook
    
    export ATUIN_SESSION=$(atuin uuid)
    export ATUIN_HISTORY="atuin history list"
    
    _atuin_preexec(){
    	id=$(atuin history start "$1")
    	export ATUIN_HISTORY_ID="$id"
    }
    
    _atuin_precmd(){
    	local EXIT="$?"
    
    	[[ -z "$ATUIN_HISTORY_ID" ]] && return
    
    
    	(RUST_LOG=error atuin history end $ATUIN_HISTORY_ID --exit $EXIT &) > /dev/null 2>&1
    }
    
    _atuin_search(){
    	emulate -L zsh
    	zle -I
    
    	# Switch to cursor mode, then back to application
    	echoti rmkx
    	# swap stderr and stdout, so that the tui stuff works
    	# TODO: not this
    	output=$(RUST_LOG=error atuin search -i $BUFFER 3>&1 1>&2 2>&3)
    	echoti smkx
    
    	if [[ -n $output ]] ; then
    		LBUFFER=$output
    	fi
    
    	zle reset-prompt
    }
    
    add-zsh-hook preexec _atuin_preexec
    add-zsh-hook precmd _atuin_precmd
    
    zle -N _atuin_search_widget _atuin_search
    
    if [[ -z $ATUIN_NOBIND ]]; then
    	bindkey '^r' _atuin_search_widget
    
    	# depends on terminal mode
    	bindkey '^[[A' _atuin_search_widget
    	bindkey '^[OA' _atuin_search_widget
    fi
  '';
  envExtra = ''
    if [ -f $HOME/go/bin/go ]; then alias godev="$HOME/go/bin/go"; fi
    if [ -f $HOME/.sensitive ]; then . $HOME/.sensitive; fi

    # may want to fiddle with these so ~/go is just my one source for all
    # things outside of the toolchain and ~/golang is for inside
    export GOBIN="$HOME/gobin"
    export GOPATH="$HOME/gopath"
    export PATH="$GOBIN:$PATH"
    export PATH="$GOPATH/bin:$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"


  '';
  plugins = [
    {
      # https://github.com/Aloxaf/fzf-tab
      name = "fzf-tab";
      file = "fzf-tab.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "Aloxaf";
        repo = "fzf-tab";
        rev = "d1dbe14870be2b4d19aa7ea49a05ce9906e461a5";
        sha256 = "1j6nrmhcdsabf98dqi87s5cf9yb5017xwnd7fxn819i18h2lf46i";
      };
    }
  ];
}
