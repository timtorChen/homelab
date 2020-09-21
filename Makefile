.PHONY: dec enc git-done-commit

dec: 
	sops -d secrets.enc.yaml > secrets.yaml

enc: 
	sops -e secrets.yaml > secrets.enc.yaml

git-done-commit: enc
	git add secrets.enc.yaml
	git commit -F commit.txt
