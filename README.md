# COASTLINE

Ein experimenteller, **monophoner MIDI-Sequencer für Max for Live**, ausgelegt auf
polyrhythmische und perkussive Patterns am Make Noise **0-Coast**.

**Stand: 0.3, Prototyp für den Host-Test.** Enthalten sind ein editierbarer
Quellpatch und `device/COASTLINE.amxd` mit eingebetteten Skripten. Der Gerätebuild
wird programmgesteuert erzeugt; sein Archivformat wurde gegen ein offizielles
Ableton-MIDI-Gerät geprüft. Laden, Transport und MIDI-Ausgabe müssen noch in
Max/Live geprüft werden. Die Node-Tests ersetzen diesen Funktionstest nicht.

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

Benötigt werden Ableton Live mit **Max for Live** und Max 8 oder neuer auf einer
von Live unterstützten Plattform. Die Zielversionen sind noch im Host zu testen.
Node ist nur für Entwicklung und Tests nötig, nicht für das spätere Device.

1. Das Repository über **Code → Download ZIP** herunterladen und entpacken.
2. Eine bisher von Hand zusammengestellte COASTLINE-Instanz aus der Spur
   entfernen. `device/COASTLINE.amxd` direkt vor ein Live-Instrument auf eine
   MIDI-Spur ziehen. Das Gerät enthält den vollständigen Patch und alle drei
   Skripte. Einstellungen für Presentation und Gerätebreite sind enthalten.
3. **RUN** einschalten und Live starten. Zahlenfelder und beide Rhythmusreihen
   müssen sichtbar sein. Zunächst mit dem internen Instrument prüfen.
4. Falls Anzeige oder MIDI-Ausgabe fehlen: über **Edit** die **Max Console**
   öffnen, den aktuellen Fehlertext notieren und zusammen mit einem Screenshot
   melden. Die programmgesteuerte `.amxd` ist ein Build für diesen Host-Test.

Bei fehlender Ausgabe zuerst links **TEST** anklicken. Der Button sendet eine
Testnote (MIDI 48, Kanal 1, eine Sekunde) über native Max-Objekte. Dafür werden
weder JavaScript noch Live-API oder Sequencer-Takt benötigt. Der Sequencer wird
dabei angehalten. Anschließend **RESET** drücken, um ihn wieder freizugeben.
Zum Testen ein internes Instrument mit kurzem Attack verwenden.

Die drei Anzeigen unten rechts helfen beim Eingrenzen:

| Anzeige | Bedeutung |
| --- | --- |
| LIVE | Von Live gemeldeter Wiedergabestatus: 1 während laufender Wiedergabe. |
| CLK | Zählt Taktimpulse des Max-Metronoms. Muss bei RUN und laufender Wiedergabe steigen. |
| MIDI | Zählt ausgegebene MIDI-Pakete, einschließlich Note-offs und TEST. Belegt die Ausgabe im Patch; der Empfang im Ziel ist zusätzlich zu prüfen. |

Wenn TEST hörbar ist und die Sequenz stillsteht, bitte LIVE und CLK melden.
Wenn MIDI steigt und das Instrument stumm bleibt, die Geräte-Reihenfolge und
Zielspur prüfen. Alle drei Werte zusammen mit aktuellen Konsolenmeldungen
angeben. Beim Laden schreibt die Engine `COASTLINE 0.3 ready` in die Konsole.

Zum Bearbeiten liegt `device/COASTLINE.maxpat` daneben. Seine drei `.js`-Dateien
müssen für die Arbeit am Quellpatch im selben Ordner bleiben. Alle Regler stehen
seit 0.2 auch in der Patching-Ansicht im sichtbaren Gerätebereich. Im Build werden
der Quellpatch und die Skripte automatisch in die `.amxd` übernommen.

`npm run package` (Node 18+ und Python 3) erzeugt zusätzlich
`dist/COASTLINE-source.zip` mit Device, Quellen und Anleitung. Das Archiv wird
gegen die Quelldateien und per ZIP-CRC geprüft. `docs/OPEN-TEST.maxpat` prüft das
Öffnen eines einfachen lokalen Patches ohne Skripte.

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

COASTLINE sendet über `midiout` ausschließlich **Noten und Note-offs** als
explizite MIDI-Bytes. A hat Velocity 101, B 77,
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
| TEST | Stoppt die Sequenz und spielt eine native Testnote auf Kanal 1. RESET gibt die Sequenz wieder frei. |
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

`npm run build` erzeugt `.maxpat` und `.amxd` aus
[`scripts/build-device.js`](scripts/build-device.js). Layoutänderungen dort
vornehmen. [`scripts/amxd.js`](scripts/amxd.js) schreibt und prüft den MIDI-Wrapper
und das Max-Ressourcenarchiv. Die Struktur wurde durch einen bytegleichen
Lese-/Schreibdurchlauf mit dem MIDI-Gerät aus dem offiziellen
[Ableton Connection Kit](https://github.com/Ableton/m4l-connection-kit) geprüft.
Dabei wurden keine fremden Patch- oder Medieninhalte in COASTLINE übernommen.

Die automatisierten Tests prüfen Verteilung und Rotation aller Patternlängen,
4:3-Unterteilung, Kollisionen, Tonhöhenzyklen, MIDI-Grenzen, deterministischen
Zufall, Ratchet-Zeitfenster und den Max-Adapter mit einem simulierten Scheduler.
Weitere Tests prüfen eingebettete Skripte, vollständige Verkabelung und sichtbare
Regler in beiden Max-Ansichten. Seit 0.3 wird die Live-ID über den folgenden
Ausgang von `live.path` übernommen und die Geräteaktivierung direkt aus
`live.thisdevice` gelesen. Die Tests prüfen diese Verbindungen, die MIDI-Bytes
und einen nativen TEST-Pfad ohne JavaScript. Sie ersetzen keinen Max-/Live-Test.
Die konkrete Host-Prüfung steht in
[`docs/HOST-TEST.md`](docs/HOST-TEST.md).
