apk update && 
	apk add neovim neovim-doc tmux git openssh ripgrep curl gcc go erlang erlang-dev rebar3

go install golang.org/x/tools/gopls@latest

wget https://s3.amazonaws.com/rebar3/rebar3 &&
	chmod +x ./rebar3 &&
	./rebar3 local install

git clone https://github.com/erlang-ls/erlang_ls.git &&
	cd erlang_ls &&
	make &&
	make install
