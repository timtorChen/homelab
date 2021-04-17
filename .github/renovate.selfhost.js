// Renovate selfhosted configs
// https://docs.renovatebot.com/self-hosted-configuration/

module.exports = {
  platform: "github",
  repositories: ["timtorChen/pi-cluster"], 
  gitAuthor: "Renovate Bot <renovate@whitesourcesoftware.com>",
  logLevel: "debug",
  onboarding: true,
  onboardingBranch: "action/config",
  onboardingConfigFileName: "renovate.json5",
};
