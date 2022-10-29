<<EOF
sh git_commit.sh message
EOF
git add .
git commit -m "$1"
git push