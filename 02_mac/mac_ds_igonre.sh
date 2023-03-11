# comment
# find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch
# mac 에서 DS_Store file delete
# https://philographer.github.io/development/gitignore-ds-store/

echo ".DS_Store" >> ~/.gitignore_global
echo "._.DS_Store" >> ~/.gitignore_global
echo "**/.DS_Store" >> ~/.gitignore_global
echo "**/._.DS_Store" >> ~/.gitignore_global

git config --global core.excludesfile ~/.gitignore_global