// Renovate selfhosted configs
// https://docs.renovatebot.com/self-hosted-configuration/

module.exports = {
  platform: "github",
  repositories: ["timtorChen/k3s-garden"], 
  gitAuthor: "Renovate Bot <renovate@whitesourcesoftware.com>",
  onboarding: true,
  onboardingBranch: "action/config",
  onboardingConfigFileName: "renovate.json5",
};
