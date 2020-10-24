locals {
  network = "${element(split("-", var.subnet), 0)}"
}

###############################################################################
#                              rules based on tags
###############################################################################

resource "google_compute_firewall" "allow-tag-ssh" {
  count         = length(var.ssh_source_ranges) > 0 ? 1 : 0
  network       = "${local.network}"
  name          = "${local.network}-ingress-tag-ssh"
  description   = "Allow SSH to machines with the 'ssh' tag"
  project       = "${var.project}"
  target_tags   = "${var.ssh_target_tags}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
