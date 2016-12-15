# Szenario

Es war einmal eine schöne Insel, auf der eine … Interessensgruppe (INDEP) in Konflikt mit der Militärverwaltung (OPFOR) geriet.
Der Chef dieser Interessengruppe (INDEP C) vermutet, daß sein Leben nicht mehr für viel gilt, und möchte sich absetzen.
Das Militär will ihn dementsprechend tatsächlich dingfest machen; und im Zweifelsfall ist ihnen "tot" auch recht.

Die Bevölkerung ist gespalten – außer den Freunden des Chefs (INDEP H) gibt es auch gesetzestreue Bürger (OPFOR H), die die Sichtweise des Militärs (OPFOR A) teilen – und als deren Informanten dienen.
Zwischen all dem existieren natürlich auch Leute, die einfach in Ruhe gelassen werden wollen, und denen Politik egal ist (CIV, AI).

# offene Fragen/Überlegungen:

* ich überleg noch, alle Nametags abzuschalten … oder ein custom-Nametag zu setzen, das nicht zwischen Fraktionen unterscheidet? Evtl auch das Radar vom sthud deaktivieren?
* u.U. Signalpistole für die opfor-Helfer

# Ziele

* INDEP Chef muß die Insel verlassen und sich ~1km davon entfernen (Trigger, Siegbedingung)
* OPFOR muß ihn töten
    * (nächste Ausbaustufe: Gefangennahme und Transport ins Gefängnis)

# Setup

## Rahmenbedingungen

* alle Parteien befreundet, um Erkennbarkeit/Einsteigen bei anderen zu ermöglichen
* Insel: Stratis
* Uhrzeit: abends (1h vor Dämmerung, 2h vor Nacht)
* Chat: nur lokal & global (hoffe das gilt auch für Marker!)
* ein technischer Zeus um Probleme zu lösen
* bluforce-tracking ist abgeschaltet

## Slots & Loadout:

* INDEP
    * INDEP C: Zivilklamotten, Chefmütze, Kompass, Bandagen, Pistole (einsteckbar), Funkgerät, ein ziviles Auto
    * INDEP H: Zivilklamotten, Karte, Kompass, Bandagen. Auf je zwei Personen ein Auto
         * bis auf die ersten drei Leute: auf der ganzen Insel verstreuter Spawn
* OPFOR
    * OPFOR A: militärische Ausrüstung, Typ RHS-Russen. Keine Pistolen!    
    * OPFOR H: Zivilklamotten, Karte, Kompass, Bandagen, Signalpistole
        * auf der ganzen Insel verstreuter Spawn
    * ein BRDM, ungepanzerte Fahrzeuge GAZ

### vermutetes Balancing für verschiedene Spielerzahlen

* 14 => 1 INDEP C + 4 INDEP H + 7 OPFOR + 2 OPFOR H
* 22 => 1 INDEP C + 6 INDEP H + 11 OPFOR + 4 OPFOR H

### Spawn

* OPFOR A: in der Basis Nähe Agia Marina
* OPFOR H: verteilt
* INDEP C + 2 INDEP H: am Südzipfel
* restliche INDEP H: verteilt

## weitere Assets

ein Flugzeug AN-2 am Hangar auf dem Flughafen

## Scripte

* bad rating ausschalten bei Kills
* ACE Interact "check papers" zeigt Namen an (advanced : wer Papiere nicht dabeihat, ist vogelfrei)
* Zivilverkehr (CIV)
* Meldung, wenn jemand im selben Fahrzeug ans Inventar geht (unabhängig von Fraktion ^^)
* Trigger am Flughafen und auf den OW-Hügeln gehen los, wenn OPFOR A (aber nicht bei OPFOR H !) die Gegend betritt
* Trigger geht los, wenn Flugzeug beschädigt, oder von OPFOR bewegt wird
    * dann spawnt für INDEP ein Marker und ein Boot irgendwo an der Nordküste als alternative Fluchtmöglichkeit
    * und jeder kriegt die Nachricht, daß INDEP gewarnt wurde
* Eventhandler, wenn jemand stirbt, der *nicht* OPFOR A ist: Zeitungsmeldung und
    * wenn der Mörder OPFOR war, gibt's ein `UPGRADE` für zwei der INDEP H
    * wenn der Mörder INDEP war, uh… gibt's ein `UPGRADE` für einen OPFOR H
* Eventhandler bei Zerstörung eines zivilen Fahrzeugs: Zeitungsmeldung und
    * wenn OPFOR schuld ist: `UPGRADE` für einen der INDEP H
* Eventhandler bei Tod eines OPFOR A: Zeitungsmeldung und
    * wenn IND schuld ist, *nach dem zweiten Tod*: ein BTR für OPFOR + ein Respawn

`UPGRADE` heißt:

* wenn keine Waffe vorhanden, erhalte eine Pistole & zwei Magazine
* wenn eine Pistole vorhanden ist, erhalte eine Langwaffe & zwei Magazine
* wenn eine Langwaffe vorhanden ist, erhalte ein Funkgerät & ein Magazin
* wenn Funkgerät vorhanden ist, erhalte zwei Magazine, eine Smoke & eine Banane

# vermutete Strategien

* INDEP könnte versuchen, die Straße zu swarmen, und OPFOR einfach durch Masse zu überrumpeln
    * counter: OPFOR A erschießt einfach alle – dadurch wird INDEP zwar Waffen kriegen – aber erst nach einigen Sekunden, und nur welche die etwas weiter weg sind
