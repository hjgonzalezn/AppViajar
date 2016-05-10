json.array!(@catalogos) do |catalogo|
  json.extract! catalogo, :id, :ctlg_categoria, :ctlg_subcategoria, :ctlg_valorCdg, :ctlg_valorDesc, :ctlg_observacion, :ctlg_estadoRegistro
  json.url catalogo_url(catalogo, format: :json)
end
