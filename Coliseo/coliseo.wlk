class ArmasFilo{
  const filo = 0
  const longitud = 0

  method poder() = filo * longitud
}

class ArmasContundentes{
  var property peso = 0

  method poder() = peso
}

object casco{
  method puntosArmadura() = 10
}

object escudo{
  method puntosArmadura(luchador) = 5 + luchador.destreza()
}

class GladiadorMirmillon{
  var property vida = 100
  const property destreza = 15
  var property fuerza = 10
  var arma = new ArmasFilo(filo = 1, longitud = 20)
  var armadura = null

  method poderAtaque() = fuerza + arma.poder()

  method defensa() = armadura.puntosArmadura() + destreza

  method cambiarArma(armaNueva) {
    arma = armaNueva
  }

  method cambiarArmadura(armaduraNueva) {
    armadura = armaduraNueva
  }

  method atacarOtroGladiador(atacado) {
    atacado.vida((atacado.vida() - (self.poderAtaque() - atacado.defensa()).abs()).max(0))  //abs para valor absoluto
  }

  method armarGrupo(gladiador) {
    const grupo = new GrupoGladiadores(nombre = "Mirmillolandia")
    grupo.add(self)
    grupo.add(gladiador)
    return grupo
  }

  method pelea(contrincante) {  // se podria verificar si no se quedo sin vida el contrinante para ver si puede devolver el golpe
    self.atacarOtroGladiador(contrincante)
    contrincante.atacarOtroGladiador(self)

    /*  ALGO TIPO ASI:
      if(contrincante.vida() > 0)
      contrincante.atacarOtroGladiador(self)
    */
  }

  method campeon() = self
  method agregarPelea() {
    
  }
}

class GladiadorDimachaer{
  var property vida = 100
  const armas = []
  const property fuerza = 10
  var property destreza = 10

  method poderAtaque() = fuerza + armas.sum({unArma => unArma.poder()})

  method defensa() = destreza / 2

  method agregarArma(arma) {
    armas.add(arma)
  }

  method atacarOtroGladiador(atacado) {
    atacado.vida((atacado.vida() - (self.poderAtaque() - atacado.defensa()).abs()).max(0))  //para que no tengo vida negativa
    destreza += 1
  }

  method armarGrupo(gladiador) {
    const componenteNombre = self.poderAtaque() + gladiador.poderAtaque()
    const grupo = new GrupoGladiadores(nombre = "D-" + componenteNombre)
    grupo.add(self)
    grupo.add(gladiador)
    return grupo
  }

  method pelea(contrincante) {  // se podria verificar si no se quedo sin vida el contrinante para ver si puede devolver el golpe
    self.atacarOtroGladiador(contrincante)
    contrincante.atacarOtroGladiador(self)

    /*  ALGO TIPO ASI:
      if(contrincante.vida() > 0)
      contrincante.atacarOtroGladiador(self)
    */
  }

  method campeon() = self
  method agregarPelea() {
    
  }
}

class GrupoGladiadores{
  const miembros = []
  var property nombre = null
  var property cantidadPeleas = 0

  method agregarPelea() {
    self.cantidadPeleas(self.cantidadPeleas() + 1)
  }

  method agregarGladiador(gladiador){
    miembros.add(gladiador)
  }

  method quitarGladiador(gladiador) {
    miembros.remove(gladiador)
  }

  method campeon() {
    return miembros.filter({miembro => miembro.vida() > 0}).max({miembro => miembro.fuerza()})
  }
}

object coliseo {

  method combate(grupo, adversario) {
    3.times{
      grupo.campeon().pelea(adversario.campeon())
    }
    grupo.agregarPelea()
    adversario.agregarPelea()
  }

  method curarGrupo(grupoGladiadores) {
    grupoGladiadores.forEach({gladiador => gladiador.vida(100)})
  }

  method curarGladiador(gladiador) {
    gladiador.vida(100)
  }

  // Codigo de un combate en donde cada miembro de un grupo pelea contra un solo gladiador

  method combateAfano(grupo, solitario) {
    3.times{
      grupo.forEach({gladiador => solitario.pelea(gladiador)})
    }
    grupo.agregarPelea()
  }
}