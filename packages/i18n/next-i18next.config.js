const path = require("node:path");
const i18n = require("../../i18n.json");

/** @type {import("next-i18next").UserConfig} */
const config = {
  i18n: {
    // Selah Wellness defaults to Latin American Spanish for visitors/new users;
    // i18n.json's "source" stays "en" since that's the translation pipeline's source language.
    defaultLocale: "es-419",
    locales: i18n.locale.targets.concat([i18n.locale.source]),
  },
  fallbackLng: {
    default: ["en"],
    zh: ["zh-CN"],
  },
  reloadOnPrerender: process.env.NODE_ENV !== "production",
  localePath: path.resolve(__dirname, "./locales"),
};

module.exports = config;
