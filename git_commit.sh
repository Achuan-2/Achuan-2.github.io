<<EOF
sh git_commit.sh message
EOF
git add .
git commit -m ":memo: $1"
git push