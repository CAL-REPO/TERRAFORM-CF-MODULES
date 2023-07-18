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
    count = (length(local.RECORD) > 0 ?
            length(local.RECORD) : 0)

    zone_id = "${local.RECORD[count.index].ZONE_ID}"
    name    = "${local.RECORD[count.index].NAME}"
    type    = "${local.RECORD[count.index].TYPE}"
    value   = "${local.RECORD[count.index].VALUE}"
    ttl     = "${local.RECORD[count.index].TTL}"
}