#let fickle = [
   == Kalap nélkül
  Ha *almát* kér,\
      adj almát és vedd fel a kalapot.\
  Ha *banánt* kér,\
      adj banánt.

   == Kalappal
  Ha *almát* kér,\
      adj banánt és vedd le a kalapot.\
  Ha *banánt* kér,
      adj almát.
]

#let frustrating = [
   == Kalap nélkül
  Ha *almát* kér,\
      adj almát és vedd fel a kalapot.\
  Ha *banánt* kér,\
      adj banánt.

   == Kalappal
  Ha *almát* kér,\
      adj banánt és vedd le a kalapot.\
  Ha *banánt* kér,
      adj banánt.
]

#let fancy = [
  == Kalap nélkül, ülve
  Ha *almát* kér,\
      adj almát és vedd fel a kalapod.\
  Ha *banánt* kér,\
      adj banánt, és állj fel.
  == Kalappal, ülve
  Ha *almát* kér,\
      adj almát és állj fel.\
  Ha *banánt* kér,\
      adj almát.
  == Kalap nélkül, állva
  Ha *almát* kér,\
      adj banánt és ülj le.\
  Ha *banánt* kér,\
      adj banánt.
  == Kalappal, állva
  Ha *almát* kér,\
      adj almát és ülj le.\
  Ha *banánt* kér,\
      adj banánt, és vedd le a kalapod.
]
#table( columns: 3,
[#fickle],
[#fickle],
[#fickle],
[#fickle],
[#fickle],
[#fickle],
[#fickle],
[#fickle],
[#fickle],
[#frustrating],
[#frustrating],
[#frustrating],
)
#pagebreak()
#table(columns: 3,
[#frustrating],
[#frustrating],
[#frustrating],
[#frustrating],
[#frustrating],
[#frustrating],
[#fancy],
[#fancy],
[#fancy],
)
#pagebreak()
#table(columns: 3,
[#fancy],
[#fancy],
[#fancy],
[#fancy],
[#fancy],
[#fancy],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
[#figure(image("./alma.jpg"))],
)

#table(columns: 2,
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
[#figure(image("./banan.jpg"))],
)
