import dbus
import urllib.request
import json
import sys


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def create_notification(co2):
    item = "org.freedesktop.Notifications"
    notfy_intf = dbus.Interface(
        dbus.SessionBus().get_object(item, "/" + item.replace(".", "/")),
        item,
    )
    notfy_intf.Notify(
        "",
        0,
        "",
        "CO2 Monitor",
        f"Open your window!\nCO2 value of {co2} detected.",
        [],
        {"urgency": 2},
        10000,
    )


def poll(notify):
    try:
        with urllib.request.urlopen("http://192.168.1.166/") as url:
            data = json.load(url)
            co2 = data["co2Concentration"]
            temp = data["temperature"]
            humidity = data["humidity"]
            eprint(
                f"Opened http://192.168.1.166. co2: {co2}, temp: {temp}, humidity: {humidity}"
            )
            sys.stdout.flush()

            if co2 > 1050:
                eprint(f"Critical co2 of {co2} detected.")
                if notify:
                    create_notification(co2)
            print(int(co2))
            sys.stdout.flush()
    except Exception as e:
        eprint("Error occured: ", e)


def main():
    eprint("CO2 Monitor started!")
    notify = len(sys.argv) == 2 and sys.argv[1] == "notify"
    poll(notify)


if __name__ == "__main__":
    main()
