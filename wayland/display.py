#!/home/piri/.pyenv/versions/allrounder/bin/python

import dbus
import urllib.request
import json

item = "org.freedesktop.Notifications"
notfy_intf = dbus.Interface(
    dbus.SessionBus().get_object(item, "/" + item.replace(".", "/")),
    item,
)


with urllib.request.urlopen("http://192.168.1.166/") as url:
    data = json.load(url)
    print(int(data["co2Concentration"]))
