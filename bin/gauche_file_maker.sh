cd ~/bin/gauche/
./gosh_dict_maker.pl /opt/local/share/gauche/0.8.13/lib /opt/local/share/gauche/site/lib
cat ./gosh_completions | gosh ./make_scheme_vim.scm ./gauche_modules ./scheme.vim.tmpl > ./scheme.vim

rm ./gauche_modules
cp ./gosh_completions ~/.gosh_completions
mv ./gosh_completions ~/.vim/dict/gauche.dict
mv ./scheme.vim ~/.vim/syntax/
