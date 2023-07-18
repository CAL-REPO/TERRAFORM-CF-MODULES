variable "DNSs" {
    type = object({
        DOMAIN = string
        RECORDs = list(object({
            NAME = string
            TYPE = string
            VALUE = string
            TTL = string
        }))
    })
    default = {
        DOMAIN = ""
        RECORDs = []
    }
}