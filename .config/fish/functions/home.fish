function home --wraps='home-manager'
	switch $argv[1]
		case "install" "remove"
				python3 ~/.config/home-manager/home.py $argv
		case '*'
				home-manager $argv
    end
end

complete -c home -a install -d 'Install a package'
complete -c home -a remove -d 'Remove a package'
