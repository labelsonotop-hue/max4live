{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 8,
      "minor": 5,
      "revision": 0,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      40,
      80,
      1460,
      1040
    ],
    "openinpresentation": 1,
    "devicewidth": 1110,
    "default_fontname": "Arial",
    "default_fontsize": 12,
    "bglocked": 0,
    "bgcolor": [
      0.075,
      0.095,
      0.11,
      1
    ],
    "editing_bgcolor": [
      0.14,
      0.16,
      0.18,
      1
    ],
    "description": "Monophonic 4:3 Euclidean MIDI generator for external synths.",
    "boxes": [
      {
        "box": {
          "id": "title",
          "maxclass": "comment",
          "patching_rect": [
            12,
            7,
            200,
            20
          ],
          "text": "COASTLINE",
          "fontsize": 21,
          "textcolor": [
            0.98,
            0.71,
            0.4,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            12,
            7,
            200,
            20
          ]
        }
      },
      {
        "box": {
          "id": "subtitle",
          "maxclass": "comment",
          "patching_rect": [
            14,
            33,
            205,
            20
          ],
          "text": "MONO / POLYRHYTHMIC MIDI",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            14,
            33,
            205,
            20
          ]
        }
      },
      {
        "box": {
          "id": "rhythm-view",
          "maxclass": "jsui",
          "patching_rect": [
            14,
            59,
            190,
            60
          ],
          "filename": "coastline-view.js",
          "jsarguments": [],
          "presentation": 1,
          "presentation_rect": [
            14,
            59,
            190,
            60
          ],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "id": "key",
          "maxclass": "comment",
          "patching_rect": [
            14,
            119,
            204,
            20
          ],
          "text": "A: 1/16     B: 1/16 or 1/8T",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            14,
            119,
            204,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-enabled",
          "maxclass": "live.toggle",
          "patching_rect": [
            14,
            142,
            17,
            17
          ],
          "presentation": 1,
          "presentation_rect": [
            14,
            142,
            17,
            17
          ],
          "varname": "enabled",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline enabled",
              "parameter_shortname": "Run",
              "parameter_type": 2,
              "parameter_enum": [
                "Off",
                "On"
              ],
              "parameter_initial_enable": 1,
              "parameter_initial": [
                1
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "run-label",
          "maxclass": "comment",
          "patching_rect": [
            34,
            141,
            33,
            20
          ],
          "text": "RUN",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            34,
            141,
            33,
            20
          ]
        }
      },
      {
        "box": {
          "id": "set-enabled",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            240,
            160,
            22
          ],
          "text": "prepend param enabled"
        }
      },
      {
        "box": {
          "id": "ui-reset",
          "maxclass": "button",
          "patching_rect": [
            76,
            144,
            17,
            17
          ],
          "presentation": 1,
          "presentation_rect": [
            76,
            142,
            17,
            17
          ]
        }
      },
      {
        "box": {
          "id": "label-reset",
          "maxclass": "comment",
          "patching_rect": [
            96,
            141,
            54,
            20
          ],
          "text": "RESET",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            96,
            141,
            54,
            20
          ]
        }
      },
      {
        "box": {
          "id": "do-reset",
          "maxclass": "message",
          "patching_rect": [
            76,
            192,
            55,
            22
          ],
          "text": "reset"
        }
      },
      {
        "box": {
          "id": "ui-panic",
          "maxclass": "button",
          "patching_rect": [
            147,
            144,
            17,
            17
          ],
          "presentation": 1,
          "presentation_rect": [
            147,
            142,
            17,
            17
          ]
        }
      },
      {
        "box": {
          "id": "label-panic",
          "maxclass": "comment",
          "patching_rect": [
            167,
            141,
            54,
            20
          ],
          "text": "PANIC",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            167,
            141,
            54,
            20
          ]
        }
      },
      {
        "box": {
          "id": "do-panic",
          "maxclass": "message",
          "patching_rect": [
            147,
            192,
            55,
            22
          ],
          "text": "panic"
        }
      },
      {
        "box": {
          "id": "a-title",
          "maxclass": "comment",
          "patching_rect": [
            226,
            8,
            160,
            20
          ],
          "text": "A / PULSE",
          "fontsize": 13,
          "textcolor": [
            0.98,
            0.62,
            0.27,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            226,
            8,
            160,
            20
          ]
        }
      },
      {
        "box": {
          "id": "label-aLength",
          "maxclass": "comment",
          "patching_rect": [
            226,
            34,
            48,
            20
          ],
          "text": "Length",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            226,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-aLength",
          "maxclass": "live.numbox",
          "patching_rect": [
            226,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            226,
            53,
            44,
            19
          ],
          "varname": "aLength",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline aLength",
              "parameter_shortname": "Length",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 32,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                16
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-aLength",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            275,
            160,
            22
          ],
          "text": "prepend param aLength"
        }
      },
      {
        "box": {
          "id": "label-aHits",
          "maxclass": "comment",
          "patching_rect": [
            277,
            34,
            48,
            20
          ],
          "text": "Hits",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            277,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-aHits",
          "maxclass": "live.numbox",
          "patching_rect": [
            277,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            277,
            53,
            44,
            19
          ],
          "varname": "aHits",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline aHits",
              "parameter_shortname": "Hits",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 32,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                5
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-aHits",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            310,
            160,
            22
          ],
          "text": "prepend param aHits"
        }
      },
      {
        "box": {
          "id": "label-aRotate",
          "maxclass": "comment",
          "patching_rect": [
            328,
            34,
            48,
            20
          ],
          "text": "Rotate",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            328,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-aRotate",
          "maxclass": "live.numbox",
          "patching_rect": [
            328,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            328,
            53,
            44,
            19
          ],
          "varname": "aRotate",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline aRotate",
              "parameter_shortname": "Rotate",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 31,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-aRotate",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            345,
            160,
            22
          ],
          "text": "prepend param aRotate"
        }
      },
      {
        "box": {
          "id": "label-blend",
          "maxclass": "comment",
          "patching_rect": [
            226,
            85,
            146,
            20
          ],
          "text": "Collision rule",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            226,
            85,
            146,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-blend",
          "maxclass": "live.menu",
          "patching_rect": [
            226,
            104,
            146,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            226,
            104,
            146,
            19
          ],
          "varname": "blend",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline blend",
              "parameter_shortname": "Collision rule",
              "parameter_type": 2,
              "parameter_enum": [
                "MERGE",
                "XOR",
                "MEET"
              ],
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "set-blend",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            380,
            160,
            22
          ],
          "text": "prepend param blend"
        }
      },
      {
        "box": {
          "id": "a-help",
          "maxclass": "comment",
          "patching_rect": [
            226,
            131,
            165,
            20
          ],
          "text": "XOR removes shared hits.",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            226,
            131,
            165,
            20
          ]
        }
      },
      {
        "box": {
          "id": "a-help2",
          "maxclass": "comment",
          "patching_rect": [
            226,
            145,
            165,
            20
          ],
          "text": "MEET keeps shared hits only.",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            226,
            145,
            165,
            20
          ]
        }
      },
      {
        "box": {
          "id": "b-title",
          "maxclass": "comment",
          "patching_rect": [
            399,
            8,
            200,
            20
          ],
          "text": "B / CROSS RHYTHM",
          "fontsize": 13,
          "textcolor": [
            0.3,
            0.78,
            0.76,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            399,
            8,
            200,
            20
          ]
        }
      },
      {
        "box": {
          "id": "label-bLength",
          "maxclass": "comment",
          "patching_rect": [
            399,
            34,
            48,
            20
          ],
          "text": "Length",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            399,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-bLength",
          "maxclass": "live.numbox",
          "patching_rect": [
            399,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            399,
            53,
            44,
            19
          ],
          "varname": "bLength",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline bLength",
              "parameter_shortname": "Length",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 32,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                7
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-bLength",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            415,
            160,
            22
          ],
          "text": "prepend param bLength"
        }
      },
      {
        "box": {
          "id": "label-bHits",
          "maxclass": "comment",
          "patching_rect": [
            450,
            34,
            48,
            20
          ],
          "text": "Hits",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            450,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-bHits",
          "maxclass": "live.numbox",
          "patching_rect": [
            450,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            450,
            53,
            44,
            19
          ],
          "varname": "bHits",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline bHits",
              "parameter_shortname": "Hits",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 32,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                3
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-bHits",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            450,
            160,
            22
          ],
          "text": "prepend param bHits"
        }
      },
      {
        "box": {
          "id": "label-bRotate",
          "maxclass": "comment",
          "patching_rect": [
            501,
            34,
            48,
            20
          ],
          "text": "Rotate",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            501,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-bRotate",
          "maxclass": "live.numbox",
          "patching_rect": [
            501,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            501,
            53,
            44,
            19
          ],
          "varname": "bRotate",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline bRotate",
              "parameter_shortname": "Rotate",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 31,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-bRotate",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            485,
            160,
            22
          ],
          "text": "prepend param bRotate"
        }
      },
      {
        "box": {
          "id": "label-bRate",
          "maxclass": "comment",
          "patching_rect": [
            399,
            85,
            146,
            20
          ],
          "text": "B subdivision",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            399,
            85,
            146,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-bRate",
          "maxclass": "live.menu",
          "patching_rect": [
            399,
            104,
            146,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            399,
            104,
            146,
            19
          ],
          "varname": "bRate",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline bRate",
              "parameter_shortname": "B subdivision",
              "parameter_type": 2,
              "parameter_enum": [
                "1/16",
                "1/8T"
              ],
              "parameter_initial_enable": 1,
              "parameter_initial": [
                1
              ]
            }
          }
        }
      },
      {
        "box": {
          "id": "set-bRate",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            520,
            160,
            22
          ],
          "text": "prepend param bRate"
        }
      },
      {
        "box": {
          "id": "b-help",
          "maxclass": "comment",
          "patching_rect": [
            399,
            131,
            190,
            20
          ],
          "text": "1/8T against A = 4:3",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            399,
            131,
            190,
            20
          ]
        }
      },
      {
        "box": {
          "id": "b-help2",
          "maxclass": "comment",
          "patching_rect": [
            399,
            145,
            190,
            20
          ],
          "text": "Independent cycle lengths.",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            399,
            145,
            190,
            20
          ]
        }
      },
      {
        "box": {
          "id": "pitch-title",
          "maxclass": "comment",
          "patching_rect": [
            578,
            8,
            250,
            20
          ],
          "text": "PITCH / GATE",
          "fontsize": 13,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            578,
            8,
            250,
            20
          ]
        }
      },
      {
        "box": {
          "id": "label-root",
          "maxclass": "comment",
          "patching_rect": [
            578,
            34,
            48,
            20
          ],
          "text": "Root #",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            578,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-root",
          "maxclass": "live.numbox",
          "patching_rect": [
            578,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            578,
            53,
            44,
            19
          ],
          "varname": "root",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline root",
              "parameter_shortname": "Root #",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 127,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                48
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-root",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            555,
            160,
            22
          ],
          "text": "prepend param root"
        }
      },
      {
        "box": {
          "id": "label-pitchLength",
          "maxclass": "comment",
          "patching_rect": [
            638,
            34,
            48,
            20
          ],
          "text": "Cycle",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            638,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitchLength",
          "maxclass": "live.numbox",
          "patching_rect": [
            638,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            638,
            53,
            44,
            19
          ],
          "varname": "pitchLength",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitchLength",
              "parameter_shortname": "Cycle",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 8,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                5
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitchLength",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            590,
            160,
            22
          ],
          "text": "prepend param pitchLength"
        }
      },
      {
        "box": {
          "id": "label-gate",
          "maxclass": "comment",
          "patching_rect": [
            698,
            34,
            48,
            20
          ],
          "text": "Gate %",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            698,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-gate",
          "maxclass": "live.numbox",
          "patching_rect": [
            698,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            698,
            53,
            44,
            19
          ],
          "varname": "gate",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline gate",
              "parameter_shortname": "Gate %",
              "parameter_type": 1,
              "parameter_mmin": 5,
              "parameter_mmax": 90,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                30
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-gate",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            625,
            160,
            22
          ],
          "text": "prepend param gate"
        }
      },
      {
        "box": {
          "id": "label-swing",
          "maxclass": "comment",
          "patching_rect": [
            758,
            34,
            48,
            20
          ],
          "text": "Swing %",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            758,
            34,
            48,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-swing",
          "maxclass": "live.numbox",
          "patching_rect": [
            758,
            53,
            44,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            758,
            53,
            44,
            19
          ],
          "varname": "swing",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline swing",
              "parameter_shortname": "Swing %",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 45,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-swing",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            660,
            160,
            22
          ],
          "text": "prepend param swing"
        }
      },
      {
        "box": {
          "id": "pitch-help",
          "maxclass": "comment",
          "patching_rect": [
            578,
            80,
            258,
            20
          ],
          "text": "Semitone offsets / independent 1/16 cycle",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            578,
            80,
            258,
            20
          ]
        }
      },
      {
        "box": {
          "id": "label-pitch0",
          "maxclass": "comment",
          "patching_rect": [
            578,
            100,
            31,
            20
          ],
          "text": "1",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            578,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch0",
          "maxclass": "live.numbox",
          "patching_rect": [
            578,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            578,
            119,
            27,
            19
          ],
          "varname": "pitch0",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch0",
              "parameter_shortname": "1",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch0",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            695,
            160,
            22
          ],
          "text": "prepend param pitch0"
        }
      },
      {
        "box": {
          "id": "label-pitch1",
          "maxclass": "comment",
          "patching_rect": [
            608,
            100,
            31,
            20
          ],
          "text": "2",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            608,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch1",
          "maxclass": "live.numbox",
          "patching_rect": [
            608,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            608,
            119,
            27,
            19
          ],
          "varname": "pitch1",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch1",
              "parameter_shortname": "2",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                7
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch1",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            730,
            160,
            22
          ],
          "text": "prepend param pitch1"
        }
      },
      {
        "box": {
          "id": "label-pitch2",
          "maxclass": "comment",
          "patching_rect": [
            638,
            100,
            31,
            20
          ],
          "text": "3",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            638,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch2",
          "maxclass": "live.numbox",
          "patching_rect": [
            638,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            638,
            119,
            27,
            19
          ],
          "varname": "pitch2",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch2",
              "parameter_shortname": "3",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch2",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            765,
            160,
            22
          ],
          "text": "prepend param pitch2"
        }
      },
      {
        "box": {
          "id": "label-pitch3",
          "maxclass": "comment",
          "patching_rect": [
            668,
            100,
            31,
            20
          ],
          "text": "4",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            668,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch3",
          "maxclass": "live.numbox",
          "patching_rect": [
            668,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            668,
            119,
            27,
            19
          ],
          "varname": "pitch3",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch3",
              "parameter_shortname": "4",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                3
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch3",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            800,
            160,
            22
          ],
          "text": "prepend param pitch3"
        }
      },
      {
        "box": {
          "id": "label-pitch4",
          "maxclass": "comment",
          "patching_rect": [
            698,
            100,
            31,
            20
          ],
          "text": "5",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            698,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch4",
          "maxclass": "live.numbox",
          "patching_rect": [
            698,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            698,
            119,
            27,
            19
          ],
          "varname": "pitch4",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch4",
              "parameter_shortname": "5",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                10
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch4",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            835,
            160,
            22
          ],
          "text": "prepend param pitch4"
        }
      },
      {
        "box": {
          "id": "label-pitch5",
          "maxclass": "comment",
          "patching_rect": [
            728,
            100,
            31,
            20
          ],
          "text": "6",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            728,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch5",
          "maxclass": "live.numbox",
          "patching_rect": [
            728,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            728,
            119,
            27,
            19
          ],
          "varname": "pitch5",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch5",
              "parameter_shortname": "6",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch5",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            870,
            160,
            22
          ],
          "text": "prepend param pitch5"
        }
      },
      {
        "box": {
          "id": "label-pitch6",
          "maxclass": "comment",
          "patching_rect": [
            758,
            100,
            31,
            20
          ],
          "text": "7",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            758,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch6",
          "maxclass": "live.numbox",
          "patching_rect": [
            758,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            758,
            119,
            27,
            19
          ],
          "varname": "pitch6",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch6",
              "parameter_shortname": "7",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                12
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch6",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            905,
            160,
            22
          ],
          "text": "prepend param pitch6"
        }
      },
      {
        "box": {
          "id": "label-pitch7",
          "maxclass": "comment",
          "patching_rect": [
            788,
            100,
            31,
            20
          ],
          "text": "8",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            788,
            100,
            31,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-pitch7",
          "maxclass": "live.numbox",
          "patching_rect": [
            788,
            119,
            27,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            788,
            119,
            27,
            19
          ],
          "varname": "pitch7",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline pitch7",
              "parameter_shortname": "8",
              "parameter_type": 1,
              "parameter_mmin": -24,
              "parameter_mmax": 24,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                7
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-pitch7",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            940,
            160,
            22
          ],
          "text": "prepend param pitch7"
        }
      },
      {
        "box": {
          "id": "pitch-help2",
          "maxclass": "comment",
          "patching_rect": [
            578,
            145,
            269,
            20
          ],
          "text": "Root uses MIDI numbers; pitch cycle runs through rests.",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            578,
            145,
            269,
            20
          ]
        }
      },
      {
        "box": {
          "id": "output-title",
          "maxclass": "comment",
          "patching_rect": [
            853,
            8,
            245,
            20
          ],
          "text": "VARIATION / MIDI",
          "fontsize": 13,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            853,
            8,
            245,
            20
          ]
        }
      },
      {
        "box": {
          "id": "label-chance",
          "maxclass": "comment",
          "patching_rect": [
            853,
            34,
            53,
            20
          ],
          "text": "Hit %",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            853,
            34,
            53,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-chance",
          "maxclass": "live.numbox",
          "patching_rect": [
            853,
            53,
            49,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            853,
            53,
            49,
            19
          ],
          "varname": "chance",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline chance",
              "parameter_shortname": "Hit %",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 100,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                100
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-chance",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            975,
            160,
            22
          ],
          "text": "prepend param chance"
        }
      },
      {
        "box": {
          "id": "label-ratchet",
          "maxclass": "comment",
          "patching_rect": [
            916,
            34,
            53,
            20
          ],
          "text": "Ratchet %",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            916,
            34,
            53,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-ratchet",
          "maxclass": "live.numbox",
          "patching_rect": [
            916,
            53,
            49,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            916,
            53,
            49,
            19
          ],
          "varname": "ratchet",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline ratchet",
              "parameter_shortname": "Ratchet %",
              "parameter_type": 1,
              "parameter_mmin": 0,
              "parameter_mmax": 100,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                20
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-ratchet",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            1010,
            160,
            22
          ],
          "text": "prepend param ratchet"
        }
      },
      {
        "box": {
          "id": "label-repeats",
          "maxclass": "comment",
          "patching_rect": [
            979,
            34,
            53,
            20
          ],
          "text": "Repeats",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            979,
            34,
            53,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-repeats",
          "maxclass": "live.numbox",
          "patching_rect": [
            979,
            53,
            49,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            979,
            53,
            49,
            19
          ],
          "varname": "repeats",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline repeats",
              "parameter_shortname": "Repeats",
              "parameter_type": 1,
              "parameter_mmin": 2,
              "parameter_mmax": 4,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                2
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-repeats",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            1045,
            160,
            22
          ],
          "text": "prepend param repeats"
        }
      },
      {
        "box": {
          "id": "label-channel",
          "maxclass": "comment",
          "patching_rect": [
            1042,
            34,
            53,
            20
          ],
          "text": "Channel",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            1042,
            34,
            53,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-channel",
          "maxclass": "live.numbox",
          "patching_rect": [
            1042,
            53,
            49,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            1042,
            53,
            49,
            19
          ],
          "varname": "channel",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline channel",
              "parameter_shortname": "Channel",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 16,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                1
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-channel",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            1080,
            160,
            22
          ],
          "text": "prepend param channel"
        }
      },
      {
        "box": {
          "id": "label-seed",
          "maxclass": "comment",
          "patching_rect": [
            853,
            100,
            70,
            20
          ],
          "text": "Seed",
          "fontsize": 10,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            853,
            100,
            70,
            20
          ]
        }
      },
      {
        "box": {
          "id": "ui-seed",
          "maxclass": "live.numbox",
          "patching_rect": [
            853,
            119,
            66,
            19
          ],
          "presentation": 1,
          "presentation_rect": [
            853,
            119,
            66,
            19
          ],
          "varname": "seed",
          "parameter_enable": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Coastline seed",
              "parameter_shortname": "Seed",
              "parameter_type": 1,
              "parameter_mmin": 1,
              "parameter_mmax": 9999,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                17
              ],
              "parameter_unitstyle": 0
            }
          }
        }
      },
      {
        "box": {
          "id": "set-seed",
          "maxclass": "newobj",
          "patching_rect": [
            1200,
            1115,
            160,
            22
          ],
          "text": "prepend param seed"
        }
      },
      {
        "box": {
          "id": "output-help",
          "maxclass": "comment",
          "patching_rect": [
            933,
            101,
            170,
            20
          ],
          "text": "Same seed = repeatable variation.",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            933,
            101,
            170,
            20
          ]
        }
      },
      {
        "box": {
          "id": "output-help2",
          "maxclass": "comment",
          "patching_rect": [
            933,
            115,
            174,
            20
          ],
          "text": "PANIC latches mute; RESET resumes.",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            933,
            115,
            174,
            20
          ]
        }
      },
      {
        "box": {
          "id": "output-help3",
          "maxclass": "comment",
          "patching_rect": [
            853,
            145,
            247,
            20
          ],
          "text": "0.2 / embedded-script prototype",
          "fontsize": 9,
          "textcolor": [
            0.72,
            0.77,
            0.79,
            1
          ],
          "presentation": 1,
          "presentation_rect": [
            853,
            145,
            247,
            20
          ]
        }
      },
      {
        "box": {
          "id": "engine",
          "maxclass": "newobj",
          "patching_rect": [
            610,
            420,
            200,
            22
          ],
          "text": "js coastline-max.js"
        }
      },
      {
        "box": {
          "id": "unpack-notes",
          "maxclass": "newobj",
          "patching_rect": [
            610,
            470,
            130,
            22
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "midi-output",
          "maxclass": "newobj",
          "patching_rect": [
            610,
            520,
            100,
            22
          ],
          "text": "noteout"
        }
      },
      {
        "box": {
          "id": "clock",
          "maxclass": "newobj",
          "patching_rect": [
            610,
            350,
            260,
            22
          ],
          "text": "metro 40 ticks @quantize 40 ticks"
        }
      },
      {
        "box": {
          "id": "ready",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            330,
            120,
            22
          ],
          "text": "live.thisdevice"
        }
      },
      {
        "box": {
          "id": "init-trigger",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            365,
            100,
            22
          ],
          "text": "t b b b"
        }
      },
      {
        "box": {
          "id": "live-set",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            420,
            145,
            22
          ],
          "text": "live.path live_set"
        }
      },
      {
        "box": {
          "id": "device-path",
          "maxclass": "newobj",
          "patching_rect": [
            300,
            420,
            170,
            22
          ],
          "text": "live.path this_device"
        }
      },
      {
        "box": {
          "id": "init-message",
          "maxclass": "message",
          "patching_rect": [
            14,
            570,
            45,
            22
          ],
          "text": "init"
        }
      },
      {
        "box": {
          "id": "playing",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            650,
            240,
            22
          ],
          "text": "live.observer @property is_playing"
        }
      },
      {
        "box": {
          "id": "playing-route",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            685,
            170,
            22
          ],
          "text": "route is_playing"
        }
      },
      {
        "box": {
          "id": "playing-method",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            720,
            170,
            22
          ],
          "text": "prepend transport"
        }
      },
      {
        "box": {
          "id": "tempo",
          "maxclass": "newobj",
          "patching_rect": [
            280,
            650,
            240,
            22
          ],
          "text": "live.observer @property tempo"
        }
      },
      {
        "box": {
          "id": "tempo-route",
          "maxclass": "newobj",
          "patching_rect": [
            280,
            685,
            170,
            22
          ],
          "text": "route tempo"
        }
      },
      {
        "box": {
          "id": "tempo-method",
          "maxclass": "newobj",
          "patching_rect": [
            280,
            720,
            170,
            22
          ],
          "text": "prepend tempo"
        }
      },
      {
        "box": {
          "id": "active",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            790,
            240,
            22
          ],
          "text": "live.observer @property is_active"
        }
      },
      {
        "box": {
          "id": "active-route",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            825,
            170,
            22
          ],
          "text": "route is_active"
        }
      },
      {
        "box": {
          "id": "active-method",
          "maxclass": "newobj",
          "patching_rect": [
            14,
            860,
            170,
            22
          ],
          "text": "prepend deviceactive"
        }
      },
      {
        "box": {
          "id": "close",
          "maxclass": "newobj",
          "patching_rect": [
            300,
            790,
            100,
            22
          ],
          "text": "closebang"
        }
      },
      {
        "box": {
          "id": "closing-panic",
          "maxclass": "message",
          "patching_rect": [
            300,
            825,
            65,
            22
          ],
          "text": "panic"
        }
      },
      {
        "box": {
          "id": "clock-note",
          "maxclass": "comment",
          "patching_rect": [
            610,
            570,
            520,
            60
          ],
          "text": "40 ticks = 1/12 quarter at Max's 480 PPQ. Tempo-relative metro uses the Live transport in a Max for Live device. MIDI generator: deliberately no MIDI input passthrough. Validate host timing in Live; classic js runs at low priority.",
          "linecount": 4
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "ui-enabled",
            0
          ],
          "destination": [
            "set-enabled",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-enabled",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-reset",
            0
          ],
          "destination": [
            "do-reset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "do-reset",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-panic",
            0
          ],
          "destination": [
            "do-panic",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "do-panic",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-aLength",
            0
          ],
          "destination": [
            "set-aLength",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-aLength",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-aHits",
            0
          ],
          "destination": [
            "set-aHits",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-aHits",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-aRotate",
            0
          ],
          "destination": [
            "set-aRotate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-aRotate",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-blend",
            0
          ],
          "destination": [
            "set-blend",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-blend",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-bLength",
            0
          ],
          "destination": [
            "set-bLength",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-bLength",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-bHits",
            0
          ],
          "destination": [
            "set-bHits",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-bHits",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-bRotate",
            0
          ],
          "destination": [
            "set-bRotate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-bRotate",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-bRate",
            0
          ],
          "destination": [
            "set-bRate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-bRate",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-root",
            0
          ],
          "destination": [
            "set-root",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-root",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitchLength",
            0
          ],
          "destination": [
            "set-pitchLength",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitchLength",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-gate",
            0
          ],
          "destination": [
            "set-gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-gate",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-swing",
            0
          ],
          "destination": [
            "set-swing",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-swing",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch0",
            0
          ],
          "destination": [
            "set-pitch0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch0",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch1",
            0
          ],
          "destination": [
            "set-pitch1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch1",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch2",
            0
          ],
          "destination": [
            "set-pitch2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch2",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch3",
            0
          ],
          "destination": [
            "set-pitch3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch3",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch4",
            0
          ],
          "destination": [
            "set-pitch4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch4",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch5",
            0
          ],
          "destination": [
            "set-pitch5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch5",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch6",
            0
          ],
          "destination": [
            "set-pitch6",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch6",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-pitch7",
            0
          ],
          "destination": [
            "set-pitch7",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-pitch7",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-chance",
            0
          ],
          "destination": [
            "set-chance",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-chance",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-ratchet",
            0
          ],
          "destination": [
            "set-ratchet",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-ratchet",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-repeats",
            0
          ],
          "destination": [
            "set-repeats",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-repeats",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-channel",
            0
          ],
          "destination": [
            "set-channel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-channel",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-seed",
            0
          ],
          "destination": [
            "set-seed",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "set-seed",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            0
          ],
          "destination": [
            "unpack-notes",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "unpack-notes",
            0
          ],
          "destination": [
            "midi-output",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "unpack-notes",
            1
          ],
          "destination": [
            "midi-output",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "unpack-notes",
            2
          ],
          "destination": [
            "midi-output",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            1
          ],
          "destination": [
            "rhythm-view",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            2
          ],
          "destination": [
            "clock",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "clock",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ready",
            0
          ],
          "destination": [
            "init-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-enabled",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-aLength",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-aHits",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-aRotate",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-blend",
            0
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-bLength",
            0
          ],
          "order": 5
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-bHits",
            0
          ],
          "order": 6
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-bRotate",
            0
          ],
          "order": 7
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-bRate",
            0
          ],
          "order": 8
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-root",
            0
          ],
          "order": 9
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitchLength",
            0
          ],
          "order": 10
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-gate",
            0
          ],
          "order": 11
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-swing",
            0
          ],
          "order": 12
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch0",
            0
          ],
          "order": 13
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch1",
            0
          ],
          "order": 14
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch2",
            0
          ],
          "order": 15
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch3",
            0
          ],
          "order": 16
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch4",
            0
          ],
          "order": 17
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch5",
            0
          ],
          "order": 18
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch6",
            0
          ],
          "order": 19
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-pitch7",
            0
          ],
          "order": 20
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-chance",
            0
          ],
          "order": 21
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-ratchet",
            0
          ],
          "order": 22
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-repeats",
            0
          ],
          "order": 23
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-channel",
            0
          ],
          "order": 24
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            2
          ],
          "destination": [
            "ui-seed",
            0
          ],
          "order": 25
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            1
          ],
          "destination": [
            "live-set",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            1
          ],
          "destination": [
            "device-path",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "init-trigger",
            0
          ],
          "destination": [
            "init-message",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "init-message",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "live-set",
            0
          ],
          "destination": [
            "playing",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "playing",
            0
          ],
          "destination": [
            "playing-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "playing-route",
            0
          ],
          "destination": [
            "playing-method",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "playing-route",
            1
          ],
          "destination": [
            "playing-method",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "playing-method",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "live-set",
            0
          ],
          "destination": [
            "tempo",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tempo",
            0
          ],
          "destination": [
            "tempo-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tempo-route",
            0
          ],
          "destination": [
            "tempo-method",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tempo-route",
            1
          ],
          "destination": [
            "tempo-method",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tempo-method",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "device-path",
            0
          ],
          "destination": [
            "active",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "active",
            0
          ],
          "destination": [
            "active-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "active-route",
            0
          ],
          "destination": [
            "active-method",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "active-route",
            1
          ],
          "destination": [
            "active-method",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "active-method",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "close",
            0
          ],
          "destination": [
            "closing-panic",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "closing-panic",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      }
    ],
    "parameters": {
      "ui-enabled": [
        "Coastline enabled",
        "Run",
        0
      ],
      "ui-aLength": [
        "Coastline aLength",
        "Length",
        0
      ],
      "ui-aHits": [
        "Coastline aHits",
        "Hits",
        0
      ],
      "ui-aRotate": [
        "Coastline aRotate",
        "Rotate",
        0
      ],
      "ui-blend": [
        "Coastline blend",
        "Collision rule",
        0
      ],
      "ui-bLength": [
        "Coastline bLength",
        "Length",
        0
      ],
      "ui-bHits": [
        "Coastline bHits",
        "Hits",
        0
      ],
      "ui-bRotate": [
        "Coastline bRotate",
        "Rotate",
        0
      ],
      "ui-bRate": [
        "Coastline bRate",
        "B subdivision",
        0
      ],
      "ui-root": [
        "Coastline root",
        "Root #",
        0
      ],
      "ui-pitchLength": [
        "Coastline pitchLength",
        "Cycle",
        0
      ],
      "ui-gate": [
        "Coastline gate",
        "Gate %",
        0
      ],
      "ui-swing": [
        "Coastline swing",
        "Swing %",
        0
      ],
      "ui-pitch0": [
        "Coastline pitch0",
        "1",
        0
      ],
      "ui-pitch1": [
        "Coastline pitch1",
        "2",
        0
      ],
      "ui-pitch2": [
        "Coastline pitch2",
        "3",
        0
      ],
      "ui-pitch3": [
        "Coastline pitch3",
        "4",
        0
      ],
      "ui-pitch4": [
        "Coastline pitch4",
        "5",
        0
      ],
      "ui-pitch5": [
        "Coastline pitch5",
        "6",
        0
      ],
      "ui-pitch6": [
        "Coastline pitch6",
        "7",
        0
      ],
      "ui-pitch7": [
        "Coastline pitch7",
        "8",
        0
      ],
      "ui-chance": [
        "Coastline chance",
        "Hit %",
        0
      ],
      "ui-ratchet": [
        "Coastline ratchet",
        "Ratchet %",
        0
      ],
      "ui-repeats": [
        "Coastline repeats",
        "Repeats",
        0
      ],
      "ui-channel": [
        "Coastline channel",
        "Channel",
        0
      ],
      "ui-seed": [
        "Coastline seed",
        "Seed",
        0
      ]
    },
    "dependency_cache": [
      {
        "name": "coastline-max.js",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "coastline-core.js",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      },
      {
        "name": "coastline-view.js",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      }
    ],
    "autosave": 0
  }
}
