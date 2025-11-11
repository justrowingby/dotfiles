{ config, pkgs, lib, ... }:
{
  services.opentelemetry-collector = {
    enable = true;
    package = pkgs.opentelemetry-collector-contrib;
    configFile = ./otel-collector-config.yaml;
  };
}
