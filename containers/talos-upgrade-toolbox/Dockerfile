FROM registry.k8s.io/kubectl:v1.33.0 AS kubectl
FROM ghcr.io/siderolabs/talosctl:v1.12.4 AS talosctl
FROM hairyhenderson/gomplate:v4.3.2 AS gomplate
FROM ghcr.io/jqlang/jq:1.8.0 AS jq
FROM mikefarah/yq:4.45.4 AS yq

FROM alpine:3.22.0
COPY --from=kubectl /bin/kubectl /bin/kubectl
COPY --from=talosctl /talosctl /bin/talosctl
COPY --from=gomplate /gomplate /bin/gomplate
COPY --from=jq /jq /bin/jq
COPY --from=yq /usr/bin/yq /bin/yq

ENTRYPOINT [ "/bin/sh" ]