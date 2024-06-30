#import "@preview/finite:0.3.0": automaton, layout
#let aut = ( ..it) => {
  show "Start":""
  automaton(..it)
}

#let maut = (..it, style: (:), radius: 0.45, curve: 0) => {
  show "Start":""
  if not style.keys().contains("transition") {
    style.insert("transition", (curve: curve, label: (dist: 0.25)))
  }
  if not style.keys().contains("state") {
    style.insert("state", (radius: radius))
  }
  automaton(..it, style: style)
}

#let parallel-layout = layout.custom.with(
  positions: (ctx, radii, states) => {
    let xinc = 1.5
    let x = xinc
    let pos = (:)
    let toprow = true
    let h = 1
    for (name, r) in radii {
      if (name == "S") {
        pos.insert(name, (0,0))
      }
      else {
      pos.insert(name, (x, if(toprow){h}else{-h}))
      if (toprow) {toprow = false;} else {toprow = true; x += xinc}
      }
    }
    return pos
  }
)

#let n-parallel-layout(y: 2) = layout.custom.with(
  positions: (ctx, radii, states) => {
    let xinc = 1.5
    let x = 0
    let xmax = x
    let names = (:)
    for (name, r) in radii {
      if names.keys().contains(name.first()) {
        names.at(name.first()).push(name)
      } else {
        names.insert(name.first(), (name,))
      }
    } 
      
    let pos = (:)
    if(names.keys().contains("S") and names.at("S")!= none) {
      for name in names.at("S") {
        pos.insert(name, (x, 0))
        xmax = x
        x += xinc
      }
    }
    let ycurr = y/2
    let states = names.len()
    if names.keys().contains("S") {
      states -= 1
    }
    if names.keys().contains("N") {
      states -= 1
    }
    let ystep = y/(states - 1)
    for row in names.keys() {
      if (row == "N" or row == "S") {continue}
      let xmid = x
      for name in names.at(row) {
        pos.insert(name, (xmid, ycurr))
        if xmid > xmax {xmax = xmid}
        xmid += xinc
      }
      ycurr -= ystep
    }
    if names.keys().contains("N") {
      for name in names.at("N") {
        xmax += xinc
        pos.insert(name, (xmax, 0))
      }
    }
    
    return pos
  }
)

#let trap-layout(h: 1.7, xinc: 1.5) = layout.custom.with(
  positions: (ctx, radii, states) => {
    let x = xinc
    let pos = (:)
    for (name, r) in radii {
      if (name == "N") {
        pos.insert(name, (x/2, -h))
      }
      else {
        pos.insert(name, (x, 0))
        x += xinc
      }
    }
    return pos
  }
)

#let subtasks(list, c: 2, cg: .1cm) = {
  let keylist = list.enumerate()
  set enum(numbering: "a)")
  align(center, {
    grid(
      columns: c,
      row-gutter: 0.4cm,
      column-gutter: cg,
      align: left,
      ..keylist.map(a => {
        if a.at(1).fields().keys().contains("children") and a.at(1).children.first().fields().keys().contains("text") and a.at(1).children.first().text.first() == "*" {

            set enum(numbering: (n) =>  str.from-unicode("a".to-unicode() + n - 1) +"*)")
        [#show regex("^\*$"): ""; #enum.item(a.at(0)+1, a.at(1))]
          } else {
            set enum(numbering: "a)")
            enum.item(a.at(0)+1, a.at(1))
          }
      })
    )
  })
}
    
#let important = text.with(red)
= Determinisztikus véges automaták
Ahol a feladat mást nem mond, az ábécé legyen $Sigma = {a, b}$.
+ Adj determinisztikus véges automatát a következő nyelvekre:
  #subtasks((
    [3 betűből álló szavak],
    [$a$ betűvel kezdődő szavak],
    [csak $a$ betűt tartalmazó szavak],
    [$b$ betűre végződő szavak],
    [3 $a$ betűt tartalmazó szavak],
    [$a$ betűt nem tartalmazó szavak, $Sigma = {a,b,c}$],
  ), cg: 1.8cm)
+ Adj meg egy determinisztikus véges automatát, mely azokat a szavakat fogadja el, amelyekben szerpel legalább 3 darab $a$ betű.

+ Milyen nyelvet fogadnak el az alábbi automaták?
  #subtasks((
    [#maut(
      (
        S: (S:"a", A:"b"),
        A: (S:"b", A: "a")
      ),
      curve: .3
    )],
    [#maut(
      (
        S: (S: "b", A: "a"),
        A: (A: "a", B: "b"),
        B: (A: "a", C: "b"),
        C: (C:"a,b")
      ),
      style: (
        A-B:(curve:.2),
        B-A:(curve:.2)
      )
    )],
    [#maut(
      (
        S:(S:"b", S1:"a"),
        S1:(B:"b", S1: "a"),
        B:(S1:"a", N:"b"),
        D:(D:"b", S1: "a"),
        N:(S1:"a", D:"b"),
      ),
      layout: n-parallel-layout(y: 3),
      style: (
        S1-S1: (anchor: bottom),
        S1-B: (curve: .2),
        B-S1: (curve: .2, label: (pos: .4)),
        S1: (label: "A"),
        N: (label: "C"),
        transition: (curve: 0, label:(dist:.18))
      )
    )],
    [#maut(
      (
        A1:(B1:"a", A2:"b"),
        B1:(A1:"a", B2:"b"),
        A2:(B2:"a", A3:"b"),
        B2:(A2:"a", B3:"b"),
        A3:(B3:"a", A1:"b"),
        B3:(A3:"a", B1:"b"),
      ),
      final: "B1",
      layout: n-parallel-layout(),
      style: (
        transition: (curve: 0, label:(dist:.19)),
        A1-B1:(curve: .2, label: (angle: 0deg)),
        B1-A1:(curve: .2, label: (angle: 0deg)),
        A2-B2:(curve: .2, label: (angle: 0deg)),
        B2-A2:(curve: .2, label: (angle: 0deg)),
        A3-B3:(curve: .2, label: (angle: 0deg)),
        B3-A3:(curve: .2, label: (angle: 0deg)),
        A3-A1:(curve: -1),
        B3-B1:(curve: 1, label: (dist:-.19)),
        A1:(label: "A"),
        A2:(label: "B"),
        A3:(label: "C"),
        B1:(label: "D"),
        B2:(label: "E"),
        B3:(label: "F"),
      )
    )]
  ))

+ Adj determinisztikus véges automatát a következő nyelvekre:
  #subtasks((
    [szavak, melyekben az $a a$ részszó pontosan egyszer szerepel],
    [szavak, melyek első és utolsó betűje megegyezik],
    [$a$ és $b$ betűket felváltva tartalmazó szavak (mint pl: $a b a b a b a$ vagy $b a b a b$)],
    [szavak, melyekben minden $a$ után $b b$ következik],
    [\*szavak, melyekben minden két $c$ közt van $a$ és $b$, $Sigma = {a,b,c}$],
    [\* $a^n b^n$ (valahány $a$, majd *ugyanannyi* $b$)]
  ))
+ Adj determinisztikus véges automatát az oszthatósági szabályokra:
  #subtasks((
    [5-tel osztható számok, $Sigma = {0,1,2,...,9}$],
    [3-mal osztható számok, $Sigma = {0,1,2,...,9}$],
    [2-vel osztható bináris számok, $Sigma = {0,1}$],
    [\*3-mal osztható bináris számok, $Sigma = {0,1}$],
  ), cg:1cm)

#pagebreak(weak: true)

=  Hiányos, nemdeterminisztikus véges automaták
+ Milyen nyelvet fogadnak el az alábbi hiányos automaták?
  #subtasks((
    [#maut((S:(S:"a")))],
    [#maut(
      (
        S:(A:"b"),
        A:(B:"a"),
        B:(C:"b"),
        C:(D:"a"),
        D:()
      ),
      final: "CD"
    )],
    [#maut((S:(S:"b", A:"a"), A:(A:"b")))],
    [#maut(
      (
        S:(S:"a", A:"b"),
        A:(S:"a")
      ),
      final: "S",
      curve: .4
    )],
  ), cg : 1cm)

+ Milyen nyelvet fogadnak el az alábbi nemdeterminisztikus automaták?
  #subtasks((
    [#maut(
      (
        S: (S:"a,b", A0:"a", B0:"b"),
        A0: (A1:"a"),
        B0: (B1:"b"),
        A1: (A1: "a,b"),
        B1: (B1: "a,b")
      ),
      final: "A1B1",
      layout: n-parallel-layout(),
      style: (
        A0: (label: "A"),
        B0: (label: "B"),
        A1: (label: "C"),
        B1: (label: "D"),
      )
    )],
    [\* #maut(
        (
          S: (S:"a", A:"a,b", N:"a,c"),
          A: (A:"a,c", S:"b", N:"b"),
          N: (N:"a,b", S:"c", A:"c")
        ),
        final: "AN",
        layout: trap-layout(h: 2.5, xinc: 3.5),
        style: (
          transition: (curve: .25, label:(dist:.2)),
          S-S: (curve:.35),
          A-A: (curve:.35),
          N-N: (curve:.35, anchor: bottom),
          N: (label: "B")
        )
    )]
  ), cg: 2cm)
#set text(hyphenate: true)
+ Adj nemdeterminisztikus véges automatát az alábbi nyelvekre! Ahol a feladat mást nem mond, az ábécé legyen $Sigma = {a, b}$. Használd ki a nemdeterminisztikusságot, törekedj arra, hogy minél kevesebb állapot felhasználásával adj helyes megodást!
  #subtasks((
    [szavak, melyekben szerepel az $a b a a b$ részszó],
    [szavak, melyekben van két olyan $b$ betű, melyek közt néggyel osztható számú $a$ van],
    [szavak, melyekben nem szerepel az $a b c$ részszó, $Sigma = {a,b,c}$],
    [olyan betűre végződőik, ami korábban nem szerepelt a szóban, $Sigma = {a,b,c}$],
    [szavak, melyekben legalább az egyik betű nem szerepel, $Sigma = {a,b,c,d}$],
    [szavak, melyekben szerepel az $a a a$ és a $b b b$ részszó is],
    [\*palindromok (tehát minden szó, ami balról és jobbról olvasva ugyanaz)],
    [\*szavak, melyekben nem szerepel sem az $a a a$, sem a $b b b$ részszó],
  ), cg: .4cm)

#pagebreak(weak: true)

=  Veremautomaták
A veremautomaták esetében a determinisztikus és nemdeterminisztikus verziók nem azonos erősségűek. A nemdeterminisztikus változattal fel tudunk ismerni olyan nyelveket, amiket a determinisztikussal nem lehet. Veremautomaták esetén ezért mindig nemdeterminisztikussal szokás dolgozni, tegyél te is így!

+ Adj veremautomatát az alábbi nyelvekre! Ahol a feladat mást nem mond, a megadott nyelvek ábécéje $Sigma = {a,b}$, a veremben viszont ezeken kívül bármilyen egyéb ábécét használhatsz.
  #subtasks(cg: .4cm, c: 3,(
    [$a^n b^n$],
    [$a^n b^m a^n$],
    [első és utolsó betű megegyezik],
    [$a^n b^m$, ahol $m >= n$],
    [ugyanannyi $a$, mint $b$],
    [$a^n b^m$, ahol $m = 2n$],
    [palindromok],
    [$a^n b^n c^m d^m$, $Sigma={a,b,c,d}$],
    [$a^n b^m c^m d^n$, $Sigma={a,b,c,d}$],
    [\*$a^n b^m$, $2n >= m >= n$],
    [\*$a^n b^n c^n$, $Sigma = {a,b,c}$],
    [\*$a^l b^m c^n$, ahol $m = l+n$, \ $Sigma = {a,b,c}$]
  ))
