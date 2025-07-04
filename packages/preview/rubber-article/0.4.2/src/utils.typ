// This file contains utility functions used in other functions.

#import "dependencies.typ": *

#let reset-eq-counter = it => {
  counter(math.equation).update(0)
  it
}

#let header-oddPage(header-line-stroke, header-title) = context {
  set text(10pt)
  set grid.hline(stroke: header-line-stroke)
  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    inset: 4pt,
    smallcaps(header-title),
    smallcaps(hydra(1)),
    grid.hline(),
  )
}

#let header-evenPage(header-line-stroke, header-title) = context {
  set text(10pt)
  set grid.hline(stroke: header-line-stroke)
  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    inset: 4pt,
    smallcaps(hydra(1)),
    smallcaps(header-title),
    grid.hline(),
  )
}

#let header-content(
  first-page-header,
  alternating-header,
  oddPage: header-oddPage,
  evenPage: header-evenPage,
) = context {
  let current = counter(page).get().first()

  if current > first-page-header and calc.rem(current, 2) == 0 {
    return evenPage
  } else if current > first-page-header {
    if alternating-header {
      return oddPage
    } else {
      return evenPage
    }
  }
}

#let outlined = state("outlined", false)

/// Balance the content of columns.
/// #show link: set text(fill:blue)
/// Credits go to: #link("https://github.com/typst/typst/issues/466")
///
/// Example usage:
/// ```typ
/// #balance(columns(n)[#lorem(80)])
/// ```
///
/// -> content
#let balance(content) = layout(size => {
  let count = content.at("count")
  let textheight = measure(content).at("height")
  let linegap = par.leading.em * textheight
  let (height,) = measure(block(width: size.width, content))
  let lines = calc.ceil((height - textheight) / count / (textheight + linegap))
  let newheight = lines * (textheight + linegap) + textheight
  [#block(height: newheight)[#content]]
})

