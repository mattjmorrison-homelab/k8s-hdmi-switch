Helm chart and deployment manifests for homelab-hdmi-switch.

Split out from the homelab-hdmi-switch repo (which keeps just app source,
tests, and CI) so the two lifecycles don't get coupled: this repo's changes
sync via ArgoCD immediately on push, while homelab-hdmi-switch's changes go
through the full build/test/publish pipeline and land here only via
Argo CD Image Updater's parameter overrides (no git commits).
