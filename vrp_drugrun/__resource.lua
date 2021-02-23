resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_script {
	'@vrp/lib/utils.lua',
	'lib/Proxy.lua',
    'server.lua'
}

client_script {
	'lib/Tunnel.lua',
	'lib/Proxy.lua',
    'client.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/script.js',
    'ui/css/style.css',
}