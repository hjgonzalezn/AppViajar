module ApplicationHelper
  def formato_documento_identidad(documentoIdentidad)
    documentoIdentidad = documentoIdentidad.to_s
    tipo = documentoIdentidad[documentoIdentidad.length - 2,documentoIdentidad.length - 1]
    numero = documentoIdentidad[0,documentoIdentidad.length - 2]
    index = 3
    while index < numero.length
        
      numero = numero.insert(numero.length - index, ".")
      index = index + 4
    end
    
    resultado =  (tipo + " " + numero).rjust(16,"_") 
    return resultado
  end
  
  def formato_numero(cifra)
    numero = cifra.to_s
    numero = numero.gsub(".",",")
    index = numero.index(",") - 3
    while index > 0
      numero = numero.insert(index, ".")
      index = index - 3
    end
    return numero
  end
end
