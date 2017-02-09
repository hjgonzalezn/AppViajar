json.array!(@causals) do |causal|
  json.extract! causal, :id, :causal_tipo, :causal_nivel, :causal_descripcion, :causal_solucion, :causal_estadoRegistro
  json.url causal_url(causal, format: :json)
end
