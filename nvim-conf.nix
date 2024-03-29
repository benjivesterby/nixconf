{ pkgs }:

let
  root=/home/benji/src/benji/nixos;
in
{
  enable = true;
  package = pkgs.neovim-unwrapped;

  vimdiffAlias = true;
  withNodeJs = false;
  withPython3 = true;
  extraPython3Packages = (ps: with ps; [
    pynvim
    unidecode
    black
    isort
  ]);
  withRuby = false;

  extraPackages = with pkgs; [
    fd # used by fzf
    rnix-lsp
    rust-analyzer
    nodePackages.typescript-language-server
    # sumneko-lua-language-server

    # treesitter README lists these as requirements
    git
    gcc # could be any C compiler
  ];

  plugins = with pkgs.vimPlugins; [
    {
      plugin = gruvbox;
      config = builtins.readFile "${root}/nvim/config/looks.vim";
    }
    {
      plugin = nerdtree;
      config = ''
        map <silent> \e :NERDTreeToggle<CR>
        map <silent> \E :NERDTreeFind<CR>
        let NERDTreeShowHidden=1
      '';
    }
    {
      plugin = lualine-nvim;
      config = ''
        lua << EOF
        ${builtins.readFile "${root}/nvim/config/plugins/lualine.lua"}
        EOF
      '';
    }
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "coc";
        version = "release";
        src = pkgs.fetchFromGitHub {
          owner = "neoclide";
          repo = "coc.nvim";
          rev = "release";
          sha256 = "bsrCvgQqIA4jD62PIcLwYdcBM+YLLKLI/x2H5c/bR50=";
        };
        meta.homepage = "https://github.com/neoclide/coc.nvim";
      };
      config = ''
        let g:coc_global_extensions = [
        	\ 'coc-css',
        	\ 'coc-git',
        	\ 'coc-html',
        	\ 'coc-json',
        	\ 'coc-markdownlint',
        	\ 'coc-actions',
        	\ 'coc-snippets',
        	\ 'coc-spell-checker',
        	\ 'coc-stylelint',
        	\ 'coc-tag',
        	\ 'coc-tabnine',
        	\ 'coc-todolist',
        	\ 'coc-yaml',
        	\ 'coc-yank'
        \ ]
      '';
    }
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "copilot-vim";
        version = "release";
        src = pkgs.fetchFromGitHub {
          owner = "github";
          repo = "copilot.vim";
          rev = "release";
          sha256 = "sha256-hm/8q08aIVWc5thh31OVpVoksVrqKD+rSHbUTxzzHaU=";
          };
       };
    }
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-go";
        version = "release";
        src = pkgs.fetchFromGitHub {
          owner = "fatih";
          repo = "vim-go";
          rev = "v1.26";
          sha256 = "B9527B9MQFDs1kLda9V2PY+6kDhNa7AjpSwiu/j09L4=";
        };
        meta.homepage = "https://github.com/fatih/vim-go";
      };
      config = ''
         imap <silent><script><expr> <c-space> copilot#Accept('\<CR>')
         imap <M-[> <Plug>(copilot-dismiss)
         imap <M-.> <Plug>(copilot-next)
         imap <M-,> <Plug>(copilot-previous)
         let g:copilot_no_tab_map = v:true
         let g:copilot_assume_mapped = v:true
         let g:copilot_filetypes = {
			\ '*': v:true,
			\ 'markdown': v:true,
			\ }
      '';
    }
    fugitive
    vim-sensible
    vim-surround
    vim-matchup
    vim-repeat
    # endwise seems to interfere with nvim-autopairs at the moment, although
    # the readme does have information about making it work with endwise
    # vim-endwise
    {
      plugin = comment-nvim;
      config = ''
        lua << EOF
        require('Comment').setup()
        EOF
      '';
    }
    tabular
    editorconfig-vim
    vim-toml
    vim-markdown
    rust-vim
    vim-javascript

    {
      # revert to nvim-treesitter once the fix for
      # https://github.com/nvim-treesitter/nvim-treesitter/issues/2849 is
      # released
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "nvim-treesitter";
        version = "2022-04-25";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-treesitter";
          repo = "nvim-treesitter";
          rev = "b1e8b61a94955d747ba8ad02cd3c0dddb1bf883f";
          sha256 = "047vzgqky7f5aas8ca9m5pif4cccjvxasf2zqiksz8j6nzj4sgf7";
        };
        meta.homepage = "https://github.com/vim-scripts/VisIncr";
      };
      config = "lua << EOF\n"
      + builtins.readFile "${root}/nvim/config/treesitter.lua"
      + "\nEOF";
    }
    nvim-treesitter-textobjects
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "nvim-treesitter-playground";
        version = "2022-04-25";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-treesitter";
          repo = "playground";
          rev = "13e2d2d63ce7bc5d875e8bdf89cb070bc8cc7a00";
          sha256 = "1klkg3n3rymb6b9im7hq9yq26mqf2v79snsqbx72am649c6qc0ns";
        };
        meta.homepage = "https://github.com/nvim-treesitter/playground";
      };
    }

    {
      plugin = vim-tmux-navigator;
      config = ''
        let g:tmux_navigator_no_mappings = 1
        nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
        nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
        nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
        if exists('$TMUX')
            autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window " . expand("%:t"))
            autocmd VimLeave * call system("tmux setw automatic-rename")
        endif
      '';
    }

    {
      plugin = nvim-lspconfig;
      config = "lua << EOF\n"
      + builtins.readFile "${root}/nvim/config/lsp.lua"
      + "\nEOF";
    }
    {
      plugin = nvim-autopairs;
      config = ''
        lua << EOF
        require('nvim-autopairs').setup({
          check_ts = true, -- check treesitter
          disable_in_macro = true,
        })
        EOF
      '';
    }
    {
      plugin = nvim-lint;
      config = "lua << EOF\n"
      + builtins.readFile "${root}/nvim/config/plugins/nvim-lint.lua"
      + "\nEOF";
    }

    lspkind-nvim
    cmp-buffer
    cmp-nvim-lsp
    cmp-nvim-lua
    cmp-path
    cmp_luasnip
    {
      plugin = nvim-cmp;
      config = "lua << EOF\n"
      + builtins.readFile "${root}/nvim/config/plugins/nvim-cmp.lua"
      + "\nEOF";
    }

    vim-nix

    {
      plugin = fzf-vim;
      config = ''
        " FZF.vim
        " let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore-dir={dist,target,node_modules,docs,rulepack/xml,experiments,code-coverage-report} --ignore .git -g ""'
        " set rtp+=/usr/local/opt/fzf " for fzf to load on start from the brew install
        " set rtp+= " for fzf to load on start from the brew install
        " let $FZF_DEFAULT_COMMAND = "fd --type f --hidden -E '.git' -E 'target/**'"
        let $FZF_DEFAULT_COMMAND = "fd --type f --hidden -E '.git'"
        nmap ; :FZF<CR>
      '';
    }

    {
      plugin = luasnip;
      config = ''
        lua << EOF
        ${builtins.readFile "${root}/nvim/config/plugins/luasnip.lua"}
        -- re-enable if i ever want to use the premade snippets from friendly-snippets
        -- for some reason, lazy_load isn't working
        -- require("luasnip/loaders/from_vscode").load({ paths = "${friendly-snippets}/share/vim-plugins/friendly-snippets/" })
        EOF
      '';
    }
    #     let g:UltiSnipsExpandTrigger="<c-q>"
    #     let g:UltiSnipsJumpForwardTrigger="<c-j>"
    #     let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    #     let g:UltiSnipsEditSplit="vertical"

    # see about upstreaming these... esp scratch.vim since it has the most starts
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "visincr";
        version = "2011-08-18";
        src = pkgs.fetchFromGitHub {
          owner = "vim-scripts";
          repo = "VisIncr";
          rev = "13e8538cf332fd131ebb60422b4a01d69078794b";
          sha256 = "1qfw3r6rp67nz0mrn603mm8knljm9ld9llra1nxyz54hs8xmhqfs";
        };
        meta.homepage = "https://github.com/vim-scripts/VisIncr";
      };
    }
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-base64";
        version = "2021-02-20";
        src = pkgs.fetchFromGitHub {
          owner = "christianrondeau";
          repo = "vim-base64";
          rev = "d15253105f6a329cd0632bf9dcbf2591fb5944b8";
          sha256 = "0im33dwmjjbd6lm2510lf7lyavza17lsl119cqjjdi9jdsrh5bbg";
        };
        meta.homepage = "https://github.com/christianrondeau/vim-base64";
      };
      config = ''
        " Visual Mode mappings
        vnoremap <silent> <leader>B c<c-r>=base64#decode(@")<cr><esc>`[v`]h
        vnoremap <silent> <leader>b c<c-r>=base64#encode(@")<cr><esc>`[v`]h

        " Regex mappings
        nnoremap <leader>b/ :%s/\v()/\=base64#encode(submatch(1))/<home><right><right><right><right><right><right>
        nnoremap <leader>B/ :%s/\v()/\=base64#decode(submatch(1))/<home><right><right><right><right><right><right>
      '';
    }
    {
      plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "scratch-vim";
        version = "2021-05-03";
        src = pkgs.fetchFromGitHub {
          owner = "mtth";
          repo = "scratch.vim";
          rev = "adf826b1ac067cdb4168cb6066431cff3a2d37a3";
          sha256 = "0gy3n1sqxmqya7xv9cb5k2y8jagvzkaz6205yjzcp44wj8qsxi1z";
        };
        meta.homepage = "https://github.com/mtth/scratch.vim";
      };
      config = ''
        let g:scratch_insert_autohide = 0
        " to change default mappings, turn mapping off and set manually
        let g:scratch_no_mappings = 1
        let g:scratch_persistence_file = '~/.nvim/scratch'
        " nmap gs <Plug>(scratch-insert-reuse)
        " xmap gs <Plug>(scratch-selection-reuse)
        " nmap gS :ScratchPreview<CR>
      '';
    }
  ];

  extraConfig = builtins.readFile "${root}/nvim/init.templ.vim";
}
