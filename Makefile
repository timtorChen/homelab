.PHONY: install
install:
	pip install -r ./ansible/pip_reqs.txt
	ansible-galaxy install -r ./ansible/galaxy_reqs.yml

.PHONY: cluster-repo-update 
cluster-repo-update:
	helmfile -f ./helmfile/helmfile.yaml repos

.PHONY: git-done
git-done: 
	git commit -F commit.txt
