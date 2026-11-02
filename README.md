# COASTLINE

Ein experimenteller, **monophoner MIDI-Sequencer für Max for Live**, ausgelegt auf
polyrhythmische und perkussive Patterns am Make Noise **0-Coast**.

**Stand: 0.1, editierbarer Prototyp.** Die Logik wird unter Node getestet; der
Max-Patch wurde hier noch nicht in Ableton Live ausgeführt. Es gibt deshalb noch
keine in Live exportierte oder geprüfte `.amxd`-Datei. Max/Live und die Hardware
sind für den abschließenden Funktionstest erforderlich.

## Musikalische Idee

- **A** verteilt Anschläge gleichmäßig auf 1–32 Sechzehntelschritte.
- **B** hat einen eigenen Rhythmus und eine eigene Zykluslänge. Wahlweise läuft B
  in Sechzehnteln oder triolischen Achteln: vier A-Schritte gegen drei B-Schritte
  pro Viertelnote. Unterschiedliche Zykluslängen erzeugen zusätzlich Polymetrik.
- **MERGE** vereinigt beide Spuren; gemeinsame Anschläge bekommen einen Akzent.
  **XOR** entfernt gemeinsame Anschläge. **MEET** spielt ausschließlich die
  Schnittmenge. Auch bei Kollisionen gibt es nur eine Stimme.
- Ein unabhängiger **Tonhöhenzyklus** mit bis zu acht Halbton-Offsets läuft auf
  dem Sechzehntelraster weiter, auch durch Pausen.
- **Hit %**, **Ratchet %**, zwei bis vier Wiederholungen, **Gate %** und **Swing %**
  formen zusätzliche Details. Ein fester **Seed** macht den Verlauf ab dem
  gleichen Start reproduzierbar. Der Zufall entwickelt sich über die Zyklen
  weiter; er wiederholt nicht automatisch jede Runde dieselben Entscheidungen.

Der Startzustand kombiniert **5/16** auf A, **3/7** auf dem triolischen B-Raster und
einen Fünferschritt-Tonhöhenzyklus. Zum Kennenlernen zuerst `Ratchet % = 0`, dann
B ein- und ausblenden, indem du `B Hits` zwischen 0 und 3 wechselst.

## In Live verwenden

Zum Übertragen der Originaldateien gibt es ein ZIP-Paket. Im Checkout erzeugt
`npm run package` (Node 18+ und Python 3) die Datei
`dist/COASTLINE-source.zip`. Das ZIP vollständig entpacken und die Dateien
unverändert verwenden. Es enthält den Quellpatch und alle drei JS-Dateien
nebeneinander sowie `ZUERST-LESEN.txt`. `OPEN-TEST.maxpat` ist ein kleiner Patch
ohne Abhängigkeiten, mit dem sich das Öffnen einer lokalen Max-Datei prüfen
lässt. Das Paket wird gegen die Quelldateien und per ZIP-CRC geprüft; dies ist
kein Nachweis eines erfolgreichen Ladens in Max.

Benötigt werden Ableton Live mit **Max for Live** und Max 8 oder neuer auf einer
von Live unterstützten Plattform. Die Zielversionen sind noch im Host zu testen.
Node ist nur für Entwicklung und Tests nötig, nicht für das spätere Device.

1. Das ZIP entpacken oder das komplette Repository lokal herunterladen. Die drei
   `.js`-Dateien müssen neben `COASTLINE.maxpat` liegen bleiben: im ZIP im Ordner
   `COASTLINE`, im Repository im Ordner `device`.
2. In Live ein leeres **Max MIDI Effect** auf eine MIDI-Spur ziehen und dessen
   **Edit**-Schaltfläche anklicken. Damit steht der richtige Gerätetyp fest.
3. Im Max-Editor zusätzlich `COASTLINE.maxpat` aus diesem Ordner öffnen. Im **Patching Mode**
   alle Objekte dieses Quellpatches auswählen und kopieren.
4. Zum Fenster des leeren MIDI-Effekts wechseln. Dort ebenfalls im Patching Mode
   die vorhandenen Objekte entfernen und die kopierten Objekte einfügen.
   Das Quellpatch-Fenster und das Gerätefenster sind zwei verschiedene Fenster.
5. In den **Patcher Inspector** des Geräts gehen: **Open in Presentation**
   einschalten und **Device Width = 1110** einstellen. Diese Patcher-Einstellungen
   werden beim Kopieren der Objekte nicht mit übertragen.
6. Das Gerät als `COASTLINE.amxd` **im gleichen Ordner wie die JS-Dateien**
   speichern. Zur Presentation-Ansicht wechseln und den Max-Editor schließen.
7. Live starten. **RUN** muss eingeschaltet sein. Zunächst mit einem internen
   Instrument prüfen; danach die Hardware anbinden.

Zum Weitergeben das in Max gespeicherte Gerät **einfrieren / Freeze Device**.
Im Projekt-/Abhängigkeitsfenster prüfen, dass `coastline-max.js`,
`coastline-core.js` und `coastline-view.js` eingeschlossen sind. Das eingefrorene
Gerät anschließend ohne Zugriff auf den Quellordner erneut laden und testen.
Ein bloßes Umbenennen von `.maxpat` in `.amxd` ersetzt diesen Export nicht.

## 0-Coast anschließen

1. MIDI-Ausgang des Interfaces mit dem MIDI-Eingang des 0-Coast verbinden;
   den zum 0-Coast gehörenden bzw. dafür passenden MIDI-Adapter verwenden.
2. Hinter COASTLINE in Live **External Instrument** einsetzen. Dort den
   Hardware-MIDI-Port und den Empfangskanal des 0-Coast auswählen. **Channel** in
   COASTLINE auf denselben Kanal setzen. Die MIDI-Note-zu-Pitch/Gate-Konfiguration
   des 0-Coast muss aktiv sein.
3. Den Audioausgang des 0-Coast an einen Audioeingang des Interfaces anschließen
   und diesen bei **Audio From** wählen. Hardware-Latenz in External Instrument
   nach Gehör oder Messung ausgleichen.
4. Alternativ MIDI direkt über **MIDI To** senden und das Audio auf einer
   separaten Audiospur abhören.

Zum Einstieg: `Gate = 15–35 %`, `Root # = 48`, kurze Contour am 0-Coast,
`Ratchet = 10–25 %`. Für einen perkussiven Grundversuch alle Pitch-Offsets auf
0 setzen. Danach einen langen Tonhöhenzyklus gegen kurze Rhythmuszyklen setzen.

COASTLINE sendet ausschließlich **Noten und Note-offs**. A hat Velocity 101, B 77,
Kollisionen 120; Ratchets werden leiser. Ob Velocity den Klang beeinflusst, hängt
von der MIDI-/Patch-Konfiguration des 0-Coast ab. Es werden keine festen
Zuordnungen zu dessen Klangparametern vorausgesetzt. MIDI-Clock, CC-Modulation
und MIDI-B-Konfiguration sind nicht Bestandteil dieser Version.

## Bedienung und Timing

| Bedienung | Verhalten |
| --- | --- |
| RUN | Ein-/Ausschalten; schaltet die eigene aktive Note aus und startet die Zyklen beim Einschalten neu. |
| RESET | Setzt alle Zyklen auf den Anfang; hebt Panic auf. |
| PANIC | Beendet die eigene aktive Note, löscht geplante Ereignisse und bleibt stumm, bis RESET, RUN oder ein neuer Transportstart erfolgt. |
| Length / Hits | Zykluslänge / Zahl gleichmäßig verteilter Anschläge; effektiv höchstens ein Hit pro Schritt. |
| Rotate | Dreht das Pattern nach rechts; der Wert wird modulo Zykluslänge ausgewertet. |
| Root # | Absolute MIDI-Notennummer, unabhängig von unterschiedlichen Oktavbezeichnungen in Max und Live. |
| Cycle / 1–8 | Länge des Tonhöhenzyklus / Halbton-Offsets relativ zum Root. |
| Gate % | Anteil am verfügbaren Zeitfenster zwischen möglichen Anschlägen; bei Ratchets entsprechend kürzer. |
| Swing % | Verzögert ungerade A-Sechzehntel; an der nächsten gemeinsamen Rasterposition begrenzt. |
| Seed | Gleiche Einstellungen, gleicher Seed und gleicher Start ergeben denselben Verlauf. |

Neue Wiedergabe beginnt die Zyklen von vorne; der Startpunkt ist relativ zum
Sequencer-Start, nicht zur Songposition. Während laufender Wiedergabe setzen
Song-Loops und Sprünge die Zyklen **nicht** zurück. Dafür RESET verwenden. Es gibt
keinen MIDI-Eingangs-Durchlass und keinen eingehenden Transpose-Modus.

Das Grundraster verwendet ein tempoabhängiges Max-`metro` mit **40 ticks** bei
480 ticks pro Viertelnote: zwölf Impulse pro Viertel. Die Live-Transportmeldung
schaltet den Generator. Ratchets und Note-offs werden über Max-`Task` geplant.
Classic Max-`js` läuft mit niedriger Priorität; dies ist **kein samplegenauer**
Sequencer. Verhalten bei Last, Tempowechseln, Transportstart und externer
MIDI-Latenz muss im Host geprüft werden. Parameteränderungen beenden laufende
Noten und geplante Ratchets, damit alte Ereignisse nicht in neue Einstellungen
hineinragen.

## Entwickeln und prüfen

Entwicklungsbefehle im vollständigen Repository: Keine npm-Pakete oder Secrets
erforderlich. Node **18+** genügt für Build und Tests:

```sh
cd /pfad/zu/max4live
npm run check
```

`npm run build` erzeugt den Max-Quellpatch aus
[`scripts/build-device.js`](scripts/build-device.js). Layoutänderungen dort
vornehmen; die generierte `.maxpat` nicht parallel von Hand bearbeiten.

Die automatisierten Tests prüfen Verteilung und Rotation aller Patternlängen,
4:3-Unterteilung, Kollisionen, Tonhöhenzyklen, MIDI-Grenzen, deterministischen
Zufall, Ratchet-Zeitfenster und den Max-Adapter mit einem simulierten Scheduler.
Sie ersetzen keinen Max-/Live-Test. Die konkrete Host-Prüfung steht in
[`docs/HOST-TEST.md`](docs/HOST-TEST.md).
