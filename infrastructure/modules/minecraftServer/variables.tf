variable "aws_region" {}
variable "aws_profile" {}
variable "project" {}
variable "custom_domain" {}

variable "ecs_ami" {
  description = "AWS ECS AMI ID"
  type        = string
  default     = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

variable "server_state" {
  description = "Running: A spot instance will launch shortly after setting this parameter; your Minecraft server should start within 5-10 minutes of changing this parameter (once UPDATE_IN_PROGRESS becomes UPDATE_COMPLETE). Stopped: Your spot instance (and thus Minecraft container) will be terminated shortly after setting this parameter."
  type        = string
  default     = "Running"
  validation {
    condition     = contains(["Running", "Stopped"], var.server_state)
    error_message = "ServerState must be either 'Running' or 'Stopped'."
  }
}

variable "instance_type" {
  description = "t3.medium is a good cost-effective instance, 2 vCPUs and 3.75 GB of RAM with moderate network performance. Change at your discretion. https://aws.amazon.com/ec2/instance-types/."
  type        = string
  default     = "t3.medium"
}

variable "spot_price" {
  description = "A t3.medium shouldn't cost much more than a cent per hour. Note: Leave this blank to use on-demand pricing."
  type        = string
  default     = "0.05"
}

variable "container_insights" {
  description = "Enable/Disable ECS Container Insights for ECS Cluster"
  type        = string
  default     = "disabled"
  validation {
    condition     = contains(["enabled", "disabled"], var.container_insights)
    error_message = "ContainerInsights must be either 'enabled' or 'disabled'."
  }
}

variable "entry_point" {
  description = "Task entrypoint (Optional - image default is script /start)"
  type        = string
  default    = ""
  
}

variable "command" {
  description = "Task command (Optional - image default is empty)"
  type        = string
  default     = ""
}

variable "log_group_name" {
  description = "(Optional - An empty value disables this feature)"
  type        = string
  default     = ""
}

variable "log_group_retention_in_days" {
  description = "(Log retention in days)"
  type        = number
  default     = 7
}

variable "log_stream_prefix" {
  description = "(Optional)"
  type        = string
  default     = "minecraft-server"
}

variable "key_pair_name" {
  description = "(Optional - An empty value disables this feature)"
  type        = string
  default     = ""
}

variable "your_ipv4" {
  description = "(Optional - An empty value disables this feature)"
  type        = string
  default     = ""
}

variable "your_ipv6" {
  description = "(Optional - An empty value disables this feature)"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "(Optional - An empty value disables this feature) If you have a hosted zone in Route 53 and wish to set a DNS record whenever your Minecraft instance starts, supply the hosted zone ID here."
  type        = string
  default     = ""
}

variable "record_name" {
  description = "(Optional - An empty value disables this feature) If you have a hosted zone in Route 53 and wish to set a DNS record whenever your Minecraft instance starts, supply the name of the record here (e.g. minecraft.mydomain.com)."
  type        = string
  default     = ""
}

variable "minecraft_image_tag" {
  description = "Java version (Examples include latest, adopt13, openj9, etc) Refer to tag descriptions available here: https://github.com/itzg/docker-minecraft-server)"
  type        = string
  default     = "latest"
}

variable "minecraft_type_tag" {
  description = "(Examples include SPIGOT, BUKKIT, TUINITY, etc) Refer to tag descriptions available here: https://github.com/itzg/docker-minecraft-server)"
  type        = string
  default     = "VANILLA"
}

variable "admin_player_names" {
  description = "Op/Administrator Players"
  type        = string
  default     = ""
}

variable "difficulty" {
  description = "The game's difficulty"
  type        = string
  default     = "normal"
  validation {
    condition     = contains(["peaceful", "easy", "normal", "hard"], var.difficulty)
    error_message = "Difficulty must be one of 'peaceful', 'easy', 'normal', or 'hard'."
  }
}

variable "whitelist" {
  description = "Usernames of your friends"
  type        = string
  default     = ""
}

variable "minecraft_version" {
  description = "Server minecraft version"
  type        = string
  default     = ""
}

variable "memory" {
  description = "How much Memory to allocate for the JVM"
  type        = string
  default     = "1G"
}

variable "seed" {
  description = "The seed used to generate the world"
  type        = string
  default     = ""
}

variable "max_players" {
  description = "Max number of players that can connect simultaneously (default 20)"
  type        = number
  default     = -1
}

variable "view_distance" {
  description = "Max view radius (in chunks) the server will send to the client (default 10)"
  type        = number
  default     = -1
}

variable "game_mode" {
  description = "Options: creative, survival (default), adventure, spectator (v1.8+)"
  type        = string
  default     = "survival"
  validation {
    condition     = contains(["creative", "survival", "adventure", "spectator"], var.game_mode)
    error_message = "GameMode must be one of 'creative', 'survival', 'adventure', or 'spectator'."
  }
}

variable "level_type" {
  description = "Options: DEFAULT, FLAT, LARGEBIOMES, AMPLIFIED, CUSTOMIZED, BUFFET, BIOMESOP (v1.12-), BIOMESOPLENTY (v1.15+)"
  type        = string
  default     = "DEFAULT"
  validation {
    condition     = contains(["DEFAULT", "FLAT", "LARGEBIOMES", "AMPLIFIED", "CUSTOMIZED", "BUFFET", "BIOMESOP", "BIOMESOPLENTY"], var.level_type)
    error_message = "LevelType must be one of 'DEFAULT', 'FLAT', 'LARGEBIOMES', 'AMPLIFIED', 'CUSTOMIZED', 'BUFFET', 'BIOMESOP', or 'BIOMESOPLENTY'."
  }
}

variable "enable_rolling_logs" {
  description = "By default the log file will grow without limit. Set to true to use a rolling log strategy."
  type        = string
  default     = "false"
  validation {
    condition     = contains(["true", "false"], var.enable_rolling_logs)
    error_message = "EnableRollingLogs must be either 'true' or 'false'."
  }
}

variable "timezone" {
  description = "Change the server's timezone. Use the canonical name of the format: Area/Location (e.g. America/New_York)"
  type        = string
  default    = "UTC"
}