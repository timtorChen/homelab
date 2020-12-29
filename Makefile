.PHONY: install
install:
	helm plugin install https://github.com/databus23/helm-diff &
	helm plugin install https://github.com/zendesk/helm-secrets &
	helm plugin install https://github.com/aslafy-z/helm-git &
	pip install -r ./ansible/pip_reqs.txt --user &
	ansible-galaxy install -r ./ansible/galaxy_reqs.yml  --force

PLY_OPT ?=

.PHONY: cluster-install
cluster-install:
	(cd ansible && ansible-playbook -i inventory/hosts.ini install.yml $(PLY_OPT))

.PHONY: cluster-repo-update 
cluster-repo-update:
	(cd helmfile && helmfile repos)

SEL  ?= -l group=none
OPT  ?= 

.PHONY: cluster-apply
cluster-apply:
	(cd helmfile && helmfile $(SEL) apply --skip-deps)

.PHONY: cluster-sync
cluster-sync:
	(cd helmfile && helmfile $(SEL) sync --skip-deps)

.PHONY: cluster-delete
cluster-delete:
	(cd helmfile && helmfile $(SEL) delete )

.PHONY: git-done
git-done: 
	git commit -F commit.txt
