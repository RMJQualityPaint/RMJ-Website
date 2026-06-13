# ============================================================
# RMJ Quality Painting — Script de fotos
# Copia y renombra las fotos a la carpeta images/ del sitio
# ============================================================

$src = "D:\RMJ images -20260613T162847Z-3-001\RMJ images"
$dst = "C:\Users\Kevin\Desktop\RMJ Website\images"

# Crear carpeta si no existe
New-Item -ItemType Directory -Force -Path $dst | Out-Null

# Mapeo: archivo actual → nombre final en el sitio web
$map = @{

    # ── YA RENOMBRADAS POR TI (solo corrijo la extensión doble) ──────────
    "cabinet-kitchen-after.jpg.JPG"       = "cabinet-kitchen-after.jpg"
    "cabinet-kitchen-before.jpg.JPG"      = "cabinet-kitchen-before.jpg"
    "exterior-brick-after.jpg.JPG"        = "exterior-brick-after.jpg"
    "exterior-brick-before.jpg.JPG"       = "exterior-brick-before.jpg"
    "exterior-commercial-after.jpg.JPG"   = "exterior-commercial-after.jpg"
    "exterior-commercial-before.jpg.JPG"  = "exterior-commercial-before.jpg"
    "epoxy-hangar-1.jpg.JPG"              = "epoxy-hangar-1.jpg"
    "epoxy-metallic-after.jpg.JPG"        = "epoxy-metallic.jpg"
    "epoxy-commercial-prep.jpg.JPG"       = "epoxy-commercial-before.jpg"
    "epoxy-large-after.jpg.JPG"           = "epoxy-commercial-after.jpg"

    # ── CÓDIGOS IMG — CONFIRMADOS ─────────────────────────────────────────
    "IMG_0627.JPG"   = "exterior-cabin-before.jpg"   # cabaña antes (amarilla/beige)
    "IMG_0628.JPG"   = "exterior-cabin-after.jpg"    # cabaña después (carbón oscuro)

    # ── CÓDIGOS IMG — MEJORES SUPOSICIONES (verifica si algo está mal) ────
    "IMG_0610.JPG"   = "interior-mural-before.jpg"   # mural antes (cinta azul)
    "IMG_0611.JPG"   = "interior-mural-after.jpg"    # mural después (colores pintados)
    "IMG_0615.JPG"   = "exterior-luxury-lake.jpg"    # casa lujo lago (atardecer)
    "IMG_0630.JPG"   = "exterior-luxury-pool.jpg"    # casa lujo piscina (aérea)
    "IMG_0620.JPG"   = "exterior-craftsman-1.jpg"    # casa craftsman blanca
    "IMG_0629.JPG"   = "exterior-craftsman-2.jpg"    # casa craftsman deck/porche
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Copiando fotos a: $dst" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$ok = 0
$fail = 0

foreach ($srcFile in ($map.Keys | Sort-Object)) {
    $srcPath = Join-Path $src $srcFile
    $dstPath = Join-Path $dst $map[$srcFile]

    if (Test-Path $srcPath) {
        Copy-Item $srcPath $dstPath -Force
        Write-Host "  OK  $srcFile" -ForegroundColor Green
        Write-Host "      -> $($map[$srcFile])" -ForegroundColor DarkGray
        $ok++
    } else {
        Write-Host "  NO ENCONTRADO: $srcFile" -ForegroundColor Red
        $fail++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Copiadas: $ok archivos" -ForegroundColor Green
if ($fail -gt 0) {
    Write-Host "  No encontrados: $fail" -ForegroundColor Red
}
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Carpeta destino: $dst" -ForegroundColor Yellow
Write-Host ""
