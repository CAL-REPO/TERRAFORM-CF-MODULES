terraform {
    required_version = ">= 1.0"
    required_providers {
        cloudflare = {
            source  = "cloudflare/cloudflare"
            version = "~> 4.0"
        }
    }
}

resource "cloudflare_record" "ADD_RECORD" {
    count = (length(var.RECORD) > 0 ?
            length(var.RECORD) : 0)

    zone_id = "${var.RECORD[count.index].ZONE_ID}"
    name    = "${var.RECORD[count.index].NAME}"
    type    = "${var.RECORD[count.index].TYPE}"
    value   = "${var.RECORD[count.index].VALUE}"
    ttl     = "${var.RECORD[count.index].TTL}"
}