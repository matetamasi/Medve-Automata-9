#import "@preview/finite:0.3.0": automaton
#let aut = (..it) => {
    show "Start":""
    automaton(..it)
}
#let important = text.with(red)
= 1. Foglalkozás

== Téma bevezetése:
- Programozás?
- Algoritmusok?
- Állapotgépek?

DVA intuitívan - egy gép, ami betűket olvas, és észben tartja, hogy hol tart, a végén pedig eldönti, hogy a szót elfogadja, vagy sem.

== Fogalmak:
- Betű - Egy darab (szétválaszthatatlan) karakter.
- Ábécé - betűk halmaza. ($Sigma$)
- Szó - Betűk egymásutánja.
- Nyelv - Szavak halmaza.
- $a^n$ $a$ betű $n$-szer egymás után leírva, ahol $a in Sigma, n in NN$

== Jelölések:
#aut((
        S: (A:0, S:1),
        A: (A:0, B:1),
        B: (B:"0,1"),
    ),
    style: (
        transition: (curve: 0)
)

)
- Állapot - Nagy (latin) betű.
- Átmenet - Állapotok közti nyíl
- Elfogadó állapot - dula karika
- $epsilon$ - üres szó
- minden állapotból kell átmenet az ábécé minden betűjére
- minden állapotból minden betű csak egyszer
#important[- szóvá kell tenni, hogy ez a DVA, lesz más is, ahol kicsit mások a szabályok]

== Közös feladatmegoldás

== Önálló feladatmegoldás

= 2. Foglalkozás

== Hiányos DVA
- elhagyhatók átmenetek
- nem definiált átmenet esetén azonnal elutasít
#important[- feladatokon keresztül vegyék észre, hogy ez is egy DVA-vá átalakítható]

== Feladatok

== NVA
- egy állapotban egy betűre több átmenet definiálható
- ha van egy megfelelő lefutás, akkor a szót elfogadjuk
- általában hiányos is (hogy kevesebbet kelljen írni)

== Feladatok

== NVA és DVA ekvivalens
- szerintük melyik az "erősebb?"
- mutassuk meg, hogy NVA alakítható DVA-vá
- vegyük észre, hogy a DVA egy NVA

= 3. Folgalkozás

== "Verseny"
(Ezt nem én találtam ki, de a tematika tanításakor népszerű szokott lenni)
- Gyerekek rendeződjenek 4-5 fős csapatokba
- Miden csapat találjon ki egy automatát annyi állapottal, ahányan vannak
- Szimulálják az automatát
- A többi csapat adjon inputokat, és próbálja meg kitalálni, hogy milyen automatát szimulálnak

= 4. Folglalkozás

== Nem mindent lehet NVA-val kifejezni
- példanyelv, amire nem tudnak automatát adni
- veremautomaták bevezetése
- közös feladatmegoldás

#pagebreak(weak: true)

= Feladatsor megoldásokkal
Ahol a feladat mást nem mond, az ábécé legyen $Sigma = {a, b}$.
+ Adj meg egy determinisztikus véges automatát, mely azokat a szavakat fogadja el, amelyekben szerpel legalább 3 darab $a$ betű.
  #aut(
    (
      S: (S: "a", A: "b"),
      A: (A: "a", B: "b"),
      B: (B: "a", C: "b"),
      C: (C: "a,b")
    ),
    style: (
      transition: (curve: 0),
      state: (
        radius: 0.45
      )
    ),
  )
+ asdf
