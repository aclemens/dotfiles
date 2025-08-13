import json
import subprocess


def get_weather(*locations: str, format: str | None = None) -> str:
    location_str = ",".join(locations)
    format_str = "" if not format else f"?format={format}"
    result = subprocess.run(
        [
            "curl",
            "--silent",
            f"wttr.in/{{{location_str}}}{format_str}",
        ],
        stdout=subprocess.PIPE,
    )
    # decode the result and return it
    return result.stdout.decode("utf-8")


def main():
    text = get_weather("Bensheim", format="%t+%C").strip()
    tooltip = get_weather(
        "Bensheim",
        "Frankfurt",
        "Windesheim",
        "Achim",
        "Tromsø",
        format=r"%l:%c%t+(%C)\n",
    ).strip()
    result = {"text": text, "tooltip": tooltip}
    print(json.dumps(result, indent=None))


if __name__ == "__main__":
    main()
