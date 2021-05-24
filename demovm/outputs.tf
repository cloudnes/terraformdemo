output "Jump_server_Public_Ip" {
    value = module.pip_jump.ip_address
}
output "Application_Gateway_Public_Ip" {
    value = module.pip_appgw.ip_address
}
output "vm_names" {
    value = ["${module.vm-1.*.name}"] 
}

output "kv_names" {
    value = ["${module.kv.name}"] 
}
output "cert_names" {
    value = ["${module.ssl_cert.name}"] 
}