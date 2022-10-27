<<EOF
sh git_commit.sh 测试wiki
EOF
git add .
git commit -m ":memo: $1"
git push