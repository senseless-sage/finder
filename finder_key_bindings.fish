function finder_key_bindings -d "CLI tool for fuzzy searching local files."
    set -g index_dir $HOME/.cache/indexed-dirs
    set -g fzf_default_opts --bind ctrl-z:ignore,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all --height 100% --preview-window down
    set -g fzf_preview_cmd_dir 'tree -l -L 3 -C {} | head -50'
    set -g fzf_preview_cmd_file 'batcat --theme ansi --color=always --style=numbers --line-range=:50 {}'
    set -g fzf_preview_cmd "test -d {} && sh -c \"$fzf_preview_cmd_dir\" || sh -c \"$fzf_preview_cmd_file\""
    set -g fzf_cp_cmd 'ctrl-y:execute-silent(echo -n {} | fish_clipboard_copy)+abort'

    function __fzf_change_dir
        __fzf_exec_cmd_on_selected_files cd d
    end

    function __fzf_find_dir -a mode
        __fzf_exec_cmd_on_selected_files __fzf_insert_selected_items_into_cmd_line d $mode
    end

    function __fzf_find_files -a mode
        __fzf_exec_cmd_on_selected_files __fzf_insert_selected_items_into_cmd_line f $mode
    end

    function __fzf_read_files -a mode
        __fzf_exec_cmd_on_selected_files batcat f $mode
    end

    function __fzf_edit_files -a mode
        __fzf_exec_cmd_on_selected_files micro f $mode
    end

    function __fzf_open_files -a mode
        __fzf_exec_cmd_on_selected_files xdg-open f $mode
    end

    function __fzf_search_history
        commandline -r (history | fzf --scheme=history --query (commandline -t) $fzf_default_opts --preview 'echo {}' \
            --preview-window up:3:hidden:wrap --bind $fzf_cp_cmd)

        commandline -f repaint
    end

    function __fzf_exec_cmd_on_selected_files -a cmd -a file_type -a mode
        set -l dir_and_query (__fzf_parse_commandline)
        set -l fd_dir (test "$mode" = "home" && set -e mode && echo $HOME || echo $dir_and_query[1])
        set -l fzf_query $dir_and_query[2]

        set -l index_file "$index_dir/$(string replace -a '/' '_' $fd_dir)-$file_type$mode.index"

        test "$mode" = -cd && set fd_opts -d 1 --type d

        if [ ! -e "$index_file" ]
            fdfind $fd_opts --type $file_type --hidden --follow . $fd_dir >$index_file
        end

        set -l selected_files (cat $index_file | fzf -m --reverse $fzf_default_opts --preview=$fzf_preview_cmd --query "$fzf_query" \
            --bind "ctrl-r:reload(fdfind $fd_opts --type $file_type --hidden --follow . $fd_dir | tee $index_file)" \
            --bind $fzf_cp_cmd)

        [ -n "$selected_files" ] && $cmd $selected_files

        commandline -f repaint
    end

    function __fzf_insert_selected_items_into_cmd_line
        commandline -t ''

        for result in $argv
            commandline -it -- (string escape $result)
            commandline -it -- ' '
        end
    end

    function __fzf_parse_commandline -d 'Parse the current command line token and split the file dir and the file name.'
        set -l file_path (commandline -t | string replace -r '^~' "$HOME" | string replace -r '^\.' (pwd) | path resolve)

        if [ -d "$file_path" ]
            echo $file_path
        else if [ -n "$file_path" ]
            echo -e "$(path dirname $file_path)\n$(path basename $file_path)"
        else
            echo (pwd)
        end
    end

    bind \ed __fzf_change_dir
    bind \cd __fzf_find_dir
    bind \cf __fzf_find_files
    bind \cr __fzf_read_files
    bind \ce __fzf_edit_files
    bind \co __fzf_open_files

    bind \ef "__fzf_find_files '-cd'"
    bind \er "__fzf_read_files '-cd'"
    bind \ee "__fzf_edit_files '-cd'"
    bind \eo "__fzf_open_files '-cd'"

    bind \eD "__fzf_find_dir 'home'"
    bind \eF "__fzf_find_files 'home'"
    bind \eR "__fzf_read_files 'home'"
    bind \eE "__fzf_edit_files 'home'"
    bind \eO "__fzf_open_files 'home'"

    bind \ch __fzf_search_history
    bind \cq delete-or-exit

    mkdir -p $index_dir
end
