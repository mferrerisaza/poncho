class Subscription < ApplicationRecord
  enum plan: [:bike, :scooter]

  enum id_type: [
    "NIT - Número de identificación tributaria",
    "CC - Cédula de ciudadanía",
    "DIE - Documento de identificación extranjero",
    "PP - Pasaporte",
    "CE - Cédula de extranjería",
    "TE - Tarjeta de extranjería",
    "TI - Tarjeta de identidad",
    "RC - Registro civil",
    "NA - No Aplica"
  ]

  enum account_type: [
    "Ahorros",
    "Corriente"
  ]

  enum country: [
    "Colombia",
  ]

  enum city: [
    "Medellín"
  ]
end
