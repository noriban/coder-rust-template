##### Variables
# These are custom values provided by the user
# when creating a Workspace using this template.
#
# dotfiles_uri: a dotfiles repo to clone on workspace start

variable "dotfiles_uri" {
  description = <<-EOF
  Dotfiles repo URI (optional)

  see https://dotfiles.github.io
  EOF
  default     = ""
}

##### Variables - END

##### code-server
# Get dotfiles
resource "coder_agent" "main" {
  arch           = "amd64"
  os             = "linux"
  startup_script = <<EOF
    #!/bin/sh
    set -x
    # Start code-server
    code-server --auth none --port 13337
    coder dotfiles -y ${var.dotfiles_uri}
    EOF
}

resource "coder_app" "code-server" {
  agent_id = coder_agent.main.id
  name     = "VSCode"
  url      = "http://localhost:13337/?folder=/home/coder"
  icon     = "/icon/code.svg"
}

##### code-server - END

##### coder
# Miscellaneous things required by Coder
# to make Docker and everything work as expected.
# Copied from https://github.com/coder/coder/blob/main/examples/templates/docker-with-dotfiles/main.tf
terraform {
  required_providers {
    coder = {
      source  = "coder/coder"
      version = "0.4.9"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.2"
    }
  }
}

data "coder_workspace" "me" {
}

resource "docker_volume" "home_volume" {
  name = "coder-${data.coder_workspace.me.owner}-${lower(data.coder_workspace.me.name)}-root"
}

resource "docker_container" "workspace" {
  count = data.coder_workspace.me.start_count
  image = "8bitz0/rust:rocky-8"
  # Uses lower() to avoid Docker restriction on container names.
  name = "coder-${data.coder_workspace.me.owner}-${lower(data.coder_workspace.me.name)}"
  dns  = ["1.1.1.1"]
  # Refer to Docker host when Coder is on localhost
  command = ["sh", "-c", replace(coder_agent.main.init_script, "127.0.0.1", "host.docker.internal")]
  env     = ["CODER_AGENT_TOKEN=${coder_agent.main.token}"]
  host {
    host = "host.docker.internal"
    ip   = "host-gateway"
  }
  volumes {
    container_path = "/home/coder/"
    volume_name    = docker_volume.home_volume.name
    read_only      = false
  }
}

resource "coder_metadata" "container_info" {
  count       = data.coder_workspace.me.start_count
  resource_id = docker_container.workspace[0].id

  item {
    key   = "image"
    value = "8bitz0/rust:rocky-8"
  }
}

##### coder - END
