# Prüfung in Ableton Live / am 0-Coast

Status: Das Laden und die native TEST-MIDI-Ausgabe wurden vom Nutzer in Live
mit 0.3 bestätigt. RUN blieb dabei stehen, LIVE meldete trotz Wiedergabe 0.
Version 0.4 ersetzt diese Anbindung und den transportabhängigen Takt; ihre
Sequencerfunktion ist noch im Host zu prüfen. In der Cloud sind weder Max noch
Live oder ein MIDI-/Audio-Interface verfügbar.

## Laden und Wiederherstellen

- `device/COASTLINE.amxd` direkt vor ein Instrument auf eine MIDI-Spur ziehen.
  Die Max-Konsole darf keine fehlenden Dateien oder Objekte melden. Das Laden
  des programmgesteuert erzeugten Gerätebuilds ist selbst Teil dieser Prüfung.
- Präsentation: beide Rhythmusreihen, alle Regler, RUN, RESET und PANIC sichtbar.
- TEST auf einem internen Instrument mit kurzem Attack abhoeren: MIDI-Note 48
  auf Kanal 1, eine Sekunde. Die Ausgabe muss auch ohne laufenden Live-Transport
  funktionieren. Danach RESET zum Fortsetzen der Sequenz verwenden.
- Bei laufender Live-Wiedergabe muss LIVE auf 1 wechseln. Mit RUN muessen CLK
  und MIDI steigen. Bleibt ein Wert stehen, den Zustand zusammen mit den
  Konsolenmeldungen protokollieren. Die MIDI-Anzeige zaehlt auch Note-offs.
- Laden bei bereits laufender Wiedergabe und sehr frueh nach dem Live-Start
  pruefen. Die direkte LiveAPI-Anbindung muss den aktuellen Status erfassen
  und bei anfangs fehlender Verbindung selbststaendig erneut versuchen.
- Root, einen Pitch-Offset, Kanal und B-Unterteilung ändern, Set speichern,
  schließen und öffnen. Werte und tatsächliche Ausgabe müssen wiederhergestellt
  sein. Zweites Device darf einen unabhängigen Zustand besitzen.
- Nur die `.amxd` in einen eigenen Ordner kopieren und von dort erneut laden.
  Die Quellen müssen während dieses Tests außerhalb des Max-Suchpfads liegen.
  So prüfen, dass alle drei eingebetteten Skripte tatsächlich aufgelöst werden.
  Erst nach diesem Test ist der Build als eigenständig geprüft zu bezeichnen.

## Host-Synchronisation und Rhythmus

Zuerst mit internem Instrument oder aufgezeichnetem MIDI arbeiten. Für isolierte
Rasterprüfungen Ratchet und Swing auf 0, Hit auf 100 und alle Pitch-Offsets auf 0.

1. **A-Raster:** A Length/Hits = 16/16, B Hits = 0. Bei 120 BPM müssen 16 Noten
   pro 4/4-Takt mit 125 ms Abstand erscheinen. Bei 90 und 150 BPM entsprechend
   166,67 und 100 ms. Abstand und Jitter messen. Version 0.4 startet relativ zur
   empfangenen Live-Meldung; absolute Ausrichtung am Songraster ist nicht
   implementiert. Den Versatz zum Live-Metronom protokollieren.
2. **B-Raster:** A Hits = 0, B Length/Hits = 3/3 und B = 1/8T. Bei 120 BPM sind
   zwölf Noten pro 4/4-Takt mit 166,67 ms Abstand zu erwarten.
3. **4:3:** beide Spuren vollständig füllen. Mit MERGE sind sechs Noten pro
   Viertelnote auf den relativen Rasterpositionen 0, 3, 4, 6, 8, 9 von 12 zu
   erwarten; mit XOR fünf, mit MEET eine. Am Anfang keine Doppelnoten.
4. **Zyklus:** Standardwerte wiederherstellen: A 5/16, B 3/7 triolisch, Pitchlänge
   5. Die Zyklen müssen unabhängig laufen. Live-Loop und Song-Locate setzen die
   Sequencerphase absichtlich nicht zurück; RESET muss sie zurücksetzen.
5. **Tempoänderung:** Tempo während laufender Noten ändern. Danach muss das neue
   Raster gelten; bereits geplante Ratchets werden beim Wechsel verworfen.

## MIDI-Lebenszyklus

- Ratchet auf 100, Repeats auf 4 setzen. Während eines Bursts Live stoppen:
  keine späteren Note-ons und keine verbleibende aktive Note.
- PANIC während eines Bursts: sofortiger Note-off, anschließend stumm. RESET
  lässt die Ausgabe wieder zu. RUN und Live-Transportstart ebenfalls prüfen.
- Während einer Note Kanal, Root, Pattern und Gate ändern. Die vorherige Note
  muss auf dem **vorherigen** Kanal ausgeschaltet werden.
- Device deaktivieren und löschen, während eine Note spielt; nachfolgende
  Noten/Ratchets dürfen nicht hängen bleiben. Bei Deaktivierung besonders prüfen,
  ob der Host den eigenen Note-off noch durchlässt.
- Zwei aufeinanderfolgende identische Noten sowie schnelle Ratchets testen.
  Jede Note braucht einen eigenen Note-off. Keine überlappenden Noten aufnehmen.
- TEST wiederholt klicken und mit RESET, PANIC, RUN, Bypass und Live-Stop
  unterbrechen. Die Testnote muss beendet und ihr geplanter Note-off verworfen
  werden, bevor die Sequenz wieder startet.
- CPU-Last erhöhen und MIDI aufnehmen. Jitter und hörbare Schwankungen bewerten;
  die Classic-js-Implementierung garantiert keine samplegenauen Ereignisse.

## Hardware

- Erst nach dem internen Test External Instrument, passenden MIDI-Adapter,
  Empfangskanal und Audioeingang des 0-Coast einstellen.
- A alleine, B alleine und beide Spuren abhören; Pitch/Gate müssen folgen.
- Gate zwischen 5 und 90 % verändern, Ratchets 2–4 sowie 60–180 BPM testen.
  Besonders bei kurzen Gates prüfen, ob der 0-Coast jeden Anschlag artikuliert.
- Mono-Verhalten und Note-off bei Live-Stop/Panic direkt am 0-Coast prüfen.
- Latenz messen oder kompensieren. Velocity-Reaktion nur bewerten, wenn sie am
  0-Coast tatsächlich entsprechend konfiguriert ist.

Erst nach erfolgreicher Durchführung Max-Version, Live-Version, Betriebssystem,
Interface, Datum und Beobachtungen ergänzen. Ein bestandener Node-Test ist kein
Nachweis für diese Host- oder Hardwareprüfungen.
