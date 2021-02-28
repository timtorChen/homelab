.PHONY: enc
enc:
	find . -name "*secret.yaml" | xargs -I {} sops -e -i {}