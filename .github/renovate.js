module.exports = {
  timezone: "Asia/Taipei",
  platform: "github",
  repositories: ["timtorChen/pi-cluster"],
  gitAuthor: "Renovate Bot <renovate@whitesourcesoftware.com>",
  logLevel: "debug",
  dependencyDashboard: true,
  onboarding: true,
  onboardingBranch: "action/config",
  commitMessagePrefix: "(bot)",
  kubernetes: {
    fileMatch: ["^gitops/.*\\.yaml$"],
  },
  regexManagers: [
    {
      datasourceTemplate: "helm",
      fileMatch: ["^gitops/.*\\.yaml$"],
      matchStrings: [
        // common helm release
        "registryUrl=(?<registryUrl>.*?)\n *chart: (?<depName>.*?)\n *version: (?<currentValue>.*?)\n",
        // common CRD - refer chart version to determine git tag should update or not
        "registryUrl=(?<registryUrl>.*?) chart=(?<depName>.*?)\n *tag: (?<currentValue>.*?)\n",
        // kube-prometheus-stack CRD
        "registryUrl=(?<registryUrl>.*?)\n *tag: (?<depName>[a-z-]+)-(?<currentValue>.*?)\n"
      ],
    },
  ],
};
