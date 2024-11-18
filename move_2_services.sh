#!/bin/bash

local lua_file="$({ find |grep "\.lua\|\.htm\|\.json"; } 2>"/dev/null")"
for a in ${lua_file}
do
    [ -n "$(grep '"vpn"' "$a")" ] && sed -i 's,"vpn","services",g' "$a"
    [ -n "$(grep '"VPN"' "$a")" ] && sed -i 's,"VPN","Services",g' "$a"
    [ -n "$(grep '\[\[vpn\]\]' "$a")" ] && sed -i 's,\[\[vpn\]\],\[\[services\]\],g' "$a"
    [ -n "$(grep 'admin/vpn' "$a")" ] && sed -i 's,admin/vpn,admin/services,g' "$a"
done

local resource_file="$({ find | grep "\.lua\|\.htm\|\.json"; } 2>"/dev/null")"
for b in ${resource_file}
do
    [ -n "$(grep "\"nas\"" "$b")" ] && sed -i "s,\"nas\",\"services\",g" "$b"
    [ -n "$(grep "\"NAS\"" "$b")" ] && sed -i "s,\"NAS\",\"Services\",g" "$b"
    [ -n "$(grep "\[\[nas\]\]" "$b")" ] && sed -i "s,\[\[nas\]\],\[\[services\]\],g" "$b"
    [ -n "$(grep "admin/nas" "$b")" ] && sed -i "s,admin/nas,admin/services,g" "$b"
done

exit 0
