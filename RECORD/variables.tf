variable "DOMAINs" {
    type = list(string)
    default = []
}

variable "DNSs" {
    type = object({
        RECORDs = list(object({
            DOMAIN = string
            NAME = string
            TYPE = string
            VALUE = string
            TTL = string
        }))
    })
    default = {
        RECORDs = []
    }
}