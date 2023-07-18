variable "RECORD" {
    type = list(object({
        ZONE_ID = string
        NAME = string
        TYPE = string
        VALUE = string
        TTL = string
    }))
    default = []
}