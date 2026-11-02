#!/usr/bin/env python3
"""Bundle the actual Max sources without requiring users to copy code from chat."""

import hashlib
import json
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUTPUT = ROOT / "dist" / "COASTLINE-source.zip"
SOURCE_FILES = {
    "COASTLINE.maxpat": ROOT / "device" / "COASTLINE.maxpat",
    "coastline-max.js": ROOT / "device" / "coastline-max.js",
    "coastline-core.js": ROOT / "device" / "coastline-core.js",
    "coastline-view.js": ROOT / "device" / "coastline-view.js",
    "OPEN-TEST.maxpat": ROOT / "docs" / "OPEN-TEST.maxpat",
    "ZUERST-LESEN.txt": ROOT / "docs" / "ZUERST-LESEN.txt",
    "README.md": ROOT / "README.md",
    "HOST-TEST.md": ROOT / "docs" / "HOST-TEST.md",
}


def main():
    data = {name: source.read_bytes() for name, source in SOURCE_FILES.items()}
    for name, content in data.items():
        if name.endswith(".maxpat"):
            patcher = json.loads(content)["patcher"]
            assert patcher["fileversion"] == 1, name
            assert patcher["boxes"], name
    for dependency in json.loads(data["COASTLINE.maxpat"])["patcher"]["dependency_cache"]:
        assert dependency["name"] in data, dependency["name"]
    manifest = ["SHA-256  |  Bytes  |  Datei"]
    for name, content in data.items():
        manifest.append(f"{hashlib.sha256(content).hexdigest()}  {len(content):6d}  {name}")
    data["DATEIEN.txt"] = ("\n".join(manifest) + "\n").encode("utf-8")

    OUTPUT.parent.mkdir(exist_ok=True)
    with zipfile.ZipFile(OUTPUT, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for name, content in data.items():
            info = zipfile.ZipInfo("COASTLINE/" + name, date_time=(2026, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.create_system = 3
            info.external_attr = 0o100644 << 16
            archive.writestr(info, content)

    # Verify the archive, exact source contents and sibling dependency paths.
    with zipfile.ZipFile(OUTPUT) as archive:
        assert archive.testzip() is None
        assert len(archive.namelist()) == len(data)
        for name, content in data.items():
            assert archive.read("COASTLINE/" + name) == content, name
    print(f"Created {OUTPUT.relative_to(ROOT)} ({OUTPUT.stat().st_size} bytes).")
    print(f"COASTLINE.maxpat: {len(data['COASTLINE.maxpat'])} bytes, "
          f"{len(json.loads(data['COASTLINE.maxpat'])['patcher']['boxes'])} objects.")
    print("Archive CRCs and all packaged files verified against their sources.")


if __name__ == "__main__":
    main()
