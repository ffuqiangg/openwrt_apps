module("luci.controller.verysync", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/verysync") then
		return
	end

	local page = entry({"admin", "services", "verysync"}, cbi("verysync"), _("Verysync"), 10)
	page.dependent = true
	page.acl_depends = { "luci-app-verysync" }
	entry({"admin","services","verysync","status"},call("act_status")).leaf=true
end

function act_status()
	local e={}
	e.running=luci.sys.call("pgrep verysync >/dev/null")==0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
