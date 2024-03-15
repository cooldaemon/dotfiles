languages=("nodejs" "python")

for language in "${languages[@]}"; do
    asdf plugin add $language
    asdf install $language latest
    asdf global $language latest
done