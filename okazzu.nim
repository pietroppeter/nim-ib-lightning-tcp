import nimib, p5
nbInit
nbUseP5
nbJsFromCode:
  var colors = @["#f70640", "#f78e2c", "#fdd903", "#cae509", "#63be93", "#81cfe5", "#299dbf", "#38187d", "#a4459f", "#f654a9", "#2F0A30"];

  type
    Form = ref object
      x, y, x0, y0, r0, r, d0, d: float
      a, t, r1, r2, r3: float 
      n: int
      col: string

  var forms: seq[Form]

  proc newForm(x, y: float): Form =
    result = new Form
    result.x = x
    result.y = y
    result.x0 = x
    result.y0 = y
    result.r0 = random(10, 25)
    result.r = result.r0
    result.d0 = random(15) * random() + 5
    result.d = result.d0
    result.n = int(random(3, 13))
    result.a = random(100)
    result.t = random(10000)
    result.r1 = random(0.01)
    result.r2 = random(0.01)
    result.r3 = random(0.01)
    result.col = random(colors)

  proc show(form: Form) =
    noStroke()
    fill(form.col)
    push()
    translate(form.x, form.y)
    rotate(form.a)
    for i in 0 ..< form.n:
      let theta = map(i, 0, form.n, 0, TAU)
      ellipse(form.r * cos(theta), form.r * sin(theta), form.d, form.d)
    pop()

  proc move(form: Form) =
    form.t += 1
    form.a = TAU * sin(form.t * form.r1);
    form.r = form.r0 * sin(form.t * form.r2);
    form.d = form.d0 * sin(form.t * form.r3);
    form.x += 0.5;
    form.y -= 0.5;
    if form.x > width:
      form.x = 0
    if form.y < 0:
      form.y = height

  setup:
    createCanvas(900, 900)

    var c = 18
    var w = width / c
    for i in 0 ..< c:
      for j in 0 ..< c:
        let x = i * w + w / 2;
        let y = j * w + w / 2;
        if ((i + j) mod 2 == 0):
          for k in 0 ..< 5:
            forms.add(newForm(x, y))
    background(0)

  draw:

    translate(width / 2, height / 2)
    scale(1.1)
    translate(-width / 2, -height / 2)
    background(255)
    for f in forms:
      f.show()
      f.move()
nbSave