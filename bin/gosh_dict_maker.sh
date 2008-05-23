gosh_dict_maker.scm | sort | uniq | grep '^...*$' > ~/.gosh_completions
cp ~/.gosh_completions ~/.vim/dict/gauche.dict
