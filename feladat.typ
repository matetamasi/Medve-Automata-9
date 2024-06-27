#import "@preview/finite:0.3.0": automaton, layout
#let aut = ( ..it) => {
  show "Start":""
  automaton(..it)
}

#let maut = (..it, style: (:), radius: 0.45, curve: 0) => {
  show "Start":""
  style.insert("transition", (curve: curve, label: (dist: 0.25)))
  style.insert("state", (radius: radius))
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

#let trap-layout = layout.custom.with(
  positions: (ctx, radii, states) => {
    let xinc = 1.5
    let x = xinc
    let pos = (:)
    for (name, r) in radii {
      if (name == "N") {
        pos.insert(name, (x/2, -1.7))
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
    ..keylist.map(a => enum.item(a.at(0)+1, a.at(1)))
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
        B-S1: (curve: .2, label: (pos: .2)),
        S1: (label: "A"),
        N: (label: "C")
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
        A1-B1:(curve: .2, label: (angle: 0deg)),
        B1-A1:(curve: .2, label: (angle: 0deg)),
        A2-B2:(curve: .2, label: (angle: 0deg)),
        B2-A2:(curve: .2, label: (angle: 0deg)),
        A3-B3:(curve: .2, label: (angle: 0deg)),
        B3-A3:(curve: .2, label: (angle: 0deg)),
        A3-A1:(curve: -1),
        B3-B1:(curve: 1),
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
    [szavak, melyekben minden két $c$ közt van $a$ és $b$, $Sigma = {a,b,c}$]
  ))
+ Adj determinisztikus véges automatát az oszthatósági szabályokra:
  #subtasks((
    [5-tel osztható számok, $Sigma = {0,1,2,...,9}$],
    [3-mal osztható számok, $Sigma = {0,1,2,...,9}$],
    [2-vel osztható bináris számok, $Sigma = {0,1}$],
    [3-mal osztható bináris számok, $Sigma = {0,1}$],
  ), cg:1cm)

#pagebreak(weak: true)

= Nemdeterminisztikus, hiányos véges automaták
