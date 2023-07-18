variable "DOMAINs" {
    type = list(string)
    default = []
}

variable "DNSs" {
    type = list(object({
        RECORDs = list(object({
            DOMAIN = string
            NAME = string
            TYPE = string
            VALUE = string
            TTL = string
        }))
    }))
    default = []
}