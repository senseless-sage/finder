set app_dir (dirname (realpath (status --current-filename)))

ln -sf $app_dir/finder_key_bindings.fish $HOME/.config/fish/functions/finder_key_bindings.fish

if [ -e "$HOME/.config/fish/functions/fish_user_key_bindings.fish" ]
    echo "Please add 'finder_key_bindings' to your fish_user_key_bindings."
else
    echo "
function fish_user_key_bindings
    finder_key_bindings
end
" > "$HOME/.config/fish/functions/fish_user_key_bindings.fish"
end
