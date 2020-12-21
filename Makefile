.PHONY: install
install:
	helm plugin install https://github.com/databus23/helm-diff
	helm plugin install https://github.com/zendesk/helm-secrets
	helm plugin install https://github.com/aslafy-z/helm-git
	pip install -r ./ansible/pip_reqs.txt
	ansible-galaxy install -r ./ansible/galaxy_reqs.yml

.PHONY: cluster-repo-update 
cluster-repo-update:
	helmfile -f ./helmfile/helmfile.yaml repos

.PHONY: git-done
git-done: 
	git commit -F commit.txt
