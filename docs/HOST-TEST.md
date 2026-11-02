# Prüfung in Ableton Live / am 0-Coast

Status: **noch nicht ausgeführt**. In der Cloud sind weder Max noch Live oder
ein MIDI-/Audio-Interface verfügbar. Diese Liste trennt die noch offenen
Integrationsprüfungen von den automatisierten Logiktests.

## Laden und Wiederherstellen

- Gerät als Max **MIDI Effect** gemäß README erstellen, neben den drei Skripten
  speichern. Die Max-Konsole darf keine fehlenden Dateien oder Objekte melden.
- Präsentation: beide Rhythmusreihen, alle Regler, RUN, RESET und PANIC sichtbar.
- Root, einen Pitch-Offset, Kanal und B-Unterteilung ändern, Set speichern,
  schließen und öffnen. Werte und tatsächliche Ausgabe müssen wiederhergestellt
  sein. Zweites Device darf einen unabhängigen Zustand besitzen.
- Gerät einfrieren. Zum Test den Quellordner verschieben und das eingefrorene
  Gerät erneut laden. Erst nach diesem Test ist es eigenständig verteilbar.

## Host-Synchronisation und Rhythmus

Zuerst mit internem Instrument oder aufgezeichnetem MIDI arbeiten. Für isolierte
Rasterprüfungen Ratchet und Swing auf 0, Hit auf 100 und alle Pitch-Offsets auf 0.

1. **A-Raster:** A Length/Hits = 16/16, B Hits = 0. Bei 120 BPM müssen 16 Noten
   pro 4/4-Takt mit 125 ms Abstand erscheinen. Bei 90 und 150 BPM entsprechend
   166,67 und 100 ms. Mit dem Live-Metronom auf Phasenlage prüfen, auch nach Start
   mitten im Takt. Ein falsches Tempo oder falsche Phase ist ein Integrationsfehler.
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
