## -----------------------------------------------------------------------------
#| label: setup
library(ggplot2)
library(ggdiagram)


## -----------------------------------------------------------------------------
#| label: circle
x <- ob_circle()
x@radius
x@circumference
x@area
x@diameter


## -----------------------------------------------------------------------------
#| label: fig-ob
#| fig-cap: Adding objects using the `ggplot` function
# Plot
ggplot() +
  ob_circle(radius = 1) +
  ob_rectangle(width = 2, 
               height = 2) + 
  coord_fixed() + 
  theme_void()


## -----------------------------------------------------------------------------
#| label: fig-theta
#| fig-cap: The center of a circle and a point at an angle.
theta <- degree(c(0, 53, 90, 138, 180, 241, 270, 338))
x <- ob_circle()
ggdiagram(font_size = 18) +
  x +
  x@center +
  x@point_at(theta)@label(theta)


## -----------------------------------------------------------------------------
#| label: s1
p1 <- ob_point(-3, 2)
p2 <- ob_point(1, 5)
s1 <- ob_segment(p1, p2)
bp <- ggdiagram(theme_function = ggplot2::theme_minimal, 
                font_size = 18)
bp +
  p1 +
  p2 +
  s1


## -----------------------------------------------------------------------------
#| label: segstyle
s1@aesthetics@style


## -----------------------------------------------------------------------------
#| label: fig-segcolor
#| fig-cap: Styling an object
s2 <- ob_segment(p1, p2, color = "green4")
bp + s2


## -----------------------------------------------------------------------------
#| label: fig-seglinewidth
#| fig-cap: Changing an object's style after it has been created.
s2@linewidth <- 3
bp + s2


## -----------------------------------------------------------------------------
#| label: fig-setprops
#| fig-cap: Setting styles in a ggplot pipeline.
bp +
  s1 |>
  set_props(color = "red",
            linetype = "dashed")


## -----------------------------------------------------------------------------
#| label: fig-squircle
#| fig-cap: The `redefault` function creates a copy of a function with new defaults
#| fig-width: 5.5
#| fig-height: 2.5
ob_squircle <- redefault(
  .f = ob_ellipse,
  m1 = 4,
  color = NA,
  fill = "black")

ggdiagram() +
  ob_squircle() +
  ob_squircle(x = 3, fill = "dodgerblue")


## -----------------------------------------------------------------------------
#| label: fig-applystyles
#| fig-cap: The `ob_style` function creates a list of styles that can be passed to other ggdiagram functions
#| fig-width: 7
#| fig-height: 5
style_shape <- ob_style(color = NA,
                        fill = "dodgerblue4",
                        family = "serif")

my_label <- redefault(
  ob_label,
  color = "white",
  fill = NA,
  family = "serif",
  size = 18
)

ggdiagram() +
  ob_circle(
    x = -3,
    style = style_shape,
    label = my_label("Circle")) +
  ob_rectangle(
    width = 3,
    style = style_shape,
    label = my_label("Rectangle")
  )  +
  ob_ellipse(
    x = 3,
    b = 1.5,
    style = style_shape,
    label = my_label("Ellipse")
  ) + 
  ob_ngon(
    y = 2,
    n = 6,
    angle = degree(90), 
    style = style_shape,
    label = my_label("Hexagon")) +
  ob_ngon(
    y = -2,
    n = 3,
    angle = degree(90),
    style = style_shape,
    label = my_label("Triangle", nudge_y = -.25))


## -----------------------------------------------------------------------------
#| label: fig-place
x <- ob_circle()
y <- ob_rectangle() |>
  place(from = x,
        where = "above",
        sep = .5)

ggdiagram() +
  x +
  y +
  connect(x, y, resect = 2)


## -----------------------------------------------------------------------------
#| label: fig-array1
#| fig-cap: "An array of 5 unit circles, separated by 0.5, pointing southeast"

ggdiagram(font_size = 18) +
  ob_circle() |>
  ob_array(k = 5,
           label = 1:5,
           where = "southeast",
           sep = .5) 


## -----------------------------------------------------------------------------
#| label: fig-indicators
#| fig-cap: A latent variable with 3 observed indicators
#| fig-width: 5.5
#| fig-height: 7

# Loadings
loadings <- c(.86, .79, .90)
error_variances <- sqrt(1 - loadings ^ 2)

ggdiagram(font_size = 16) +
  # Latent variable
  {A <- ob_circle(radius = 2,
                  label = ob_label("A",
                                   size = 96,
                                   nudge_y = -.15))} +
  # Observed variables (array of 3 superellipses below A)
  {A_3 <- ob_ellipse(m1 = 20) |>
    place(from = A,
          where = "below",
          sep = 3) |>
    ob_array(
      k = 3,
      sep = .5,
      label = ob_label(
        label = paste0("A~", 1:3, "~"),
        size = 32,
        vjust = .6
      )
    )} +
  # Observed variable loadings with labels set to the same y coordinate
  connect(
    from = A,
    to = A_3,
    resect = 2,
    label = ob_label(label = round_probability(loadings),
                     angle = 0))@set_label_y() +
  # Error variances
  ob_variance(
    A_3,
    where = "south",
    looseness = 1.2,
    bend = -20,
    label = ob_label(label = round_probability(error_variances))
  )


## -----------------------------------------------------------------------------
arrowhead()


## -----------------------------------------------------------------------------
set_default_arrowhead(ggarrow::arrow_head_wings(offset = 30))
arrowhead()


## -----------------------------------------------------------------------------
ggdiagram() +
  x +
  y +
  connect(x, y, resect = 2)


## -----------------------------------------------------------------------------
set_default_arrowhead()
arrowhead()

