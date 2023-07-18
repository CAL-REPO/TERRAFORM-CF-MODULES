terraform {
    required_version = ">= 1.0"
    required_providers {
        cloudflare = {
            source  = "cloudflare/cloudflare"
            version = "~> 4.0"
        }
    }
}

data "cloudflare_zone" "ZONE" {
    count = (length("${var.DNSs.RECORDs}") > 0 ?
            length("${var.DNSs.RECORDs}") : 0)
    zone_name = "${var.DNSs.RECORDs[count.index].DOMAIN}"
}

resource "cloudflare_record" "ADD_RECORD" {
    count = (length("${var.DNSs.RECORDs}") > 0 ?
            length("${var.DNSs.RECORDs}") : 0)

    zone_id = "${cloudflare_zone.ZONE[count.index].ID}"
    name    = "${var.DNSs.RECORDs[count.index].NAME}"
    type    = "${var.DNSs.RECORDs[count.index].TYPE}"
    value   = "${var.DNSs.RECORDs[count.index].VALUE}"
    ttl     = "${var.DNSs.RECORDs[count.index].TTL}"
}

resource "null_resource" "WAIT_RECORD_STATUS" {
    depends_on = [ cloudflare_record.ADD_RECORD ]

    provisioner "local-exec" {
        command = <<-EOF
        EXPECTED_RECORD="${var.DNSs.RECORDs[count.index].VALUE}"

        while : ; do
            REGISTERED_RECORD="$(dig +short "${var.DNSs.RECORDs[count.index].NAME}.${var.DNSs.RECORDs[count.index].DOMAIN}" "${var.DNSs.RECORDs[count.index].TYPE}")"
            EXPECTED_RECORD_EXISTS=true

            if [[ "$REGISTERED_RECORD" != *"$EXPECTED_RECORD"* ]]; then
                EXPECTED_RECORD_EXISTS=false
                break
            fi

            if $EXPECTED_RECORD_EXISTS = true; then
                echo "Record is activated"
                break
            else
                sleep 5
            fi
        done
        EOF
        interpreter = ["bash", "-c"]
    }
}

