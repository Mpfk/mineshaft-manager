resource "aws_s3_bucket" "cloudformation_template" {
    bucket = "${var.project}-cloudformation-template"
}

data "http" "minecraft_template" {
  url = "https://raw.githubusercontent.com/vatertime/minecraft-spot-pricing/babcb9e4986382a91d30497445705bc5d7d0213c/cf.yml"
}

resource "aws_s3_object" "template" {
  bucket = aws_s3_bucket.cloudformation_template.id
  key    = "github-vatertime-minecraft-spot-pricing.yml"
  content = data.http.minecraft_template.response_body
}

locals {
  parameters = {
    ECSAMI = var.ecs_ami,
    ServerState = var.server_state,
    InstanceType = var.instance_type,
    SpotPrice = var.spot_price,
    ContainerInsights = var.container_insights,
    LogGroupName = var.log_group_name,
    LogGroupRetentionInDays = var.log_group_retention_in_days,
    LogStreamPrefix = var.log_stream_prefix,
    KeyPairName = var.key_pair_name,
    YourIPv4 = var.your_ipv4,
    YourIPv6 = var.your_ipv6,
    HostedZoneId = var.hosted_zone_id,
    RecordName = var.record_name,
    MinecraftImageTag = var.minecraft_image_tag,
    MinecraftTypeTag = var.minecraft_type_tag,
    AdminPlayerNames = var.admin_player_names,
    Difficulty = var.difficulty,
    Whitelist = var.whitelist,
    MinecraftVersion = var.minecraft_version,
    Memory = var.memory,
    Seed = var.seed,
    MaxPlayers = var.max_players,
    ViewDistance = var.view_distance,
    GameMode = var.game_mode,
    LevelType = var.level_type,
    EnableRollingLogs = var.enable_rolling_logs,
    Timezone = var.timezone
    EntryPoint = var.entry_point
    Command = var.command
  }
}

resource "aws_cloudformation_stack" "minecraft" {
  name         = "${var.project}-server"
  template_url = "https://${aws_s3_bucket.cloudformation_template.bucket_regional_domain_name}/${aws_s3_object.template.key}"
  parameters = local.parameters
  capabilities = ["CAPABILITY_IAM"]
}