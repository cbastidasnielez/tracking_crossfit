Protocolo 6 Meses · RX — Carlos (v2 · mini-ERP)
Web personal de seguimiento del plan completo: diagnóstico, dieta, entrenos, registros con gráficas, panel diario, alertas automáticas y análisis. Los registros se guardan en Supabase (base de datos en la nube) y se sincronizan entre dispositivos. Sin Supabase funciona igual en modo local (solo ese navegador).

Qué hay de nuevo en v2
HOY — panel de mando: semana X de 26 con cinta de periodización por fases, sesión del día según la semana tipo, menú de hoy con macros reales y registro de comidas con un toque, readiness del último check-in, KPIs (peso, W/bpm, press e1RM, % WODs RX cerrados 30 días) y avisos automáticos: pesaje atrasado, peso fuera de banda o cayendo, test de press pendiente (>14 días), semana sin Z2, sueño medio bajo, dieta floja.
DIETA — la dieta semanal cerrada real: los 3 fijos (Bowl, pre-entreno rotando A/B/C, post-entreno, pre-sueño), el menú comida a comida de cada día con sus macros, batch cooking de domingo, lista de la compra, reglas de intercambio y chuleta de nevera.
Comidas — registro de lo que comes: en Hoy, un toque marca cada comida del menú del día como hecha (y otro toque sobre "✓ hecho" lo deshace); en Registros → Comidas puedes añadir cualquier otra cosa (o una comida distinta a la planificada) con momento, descripción y kcal aproximadas. La tarjeta de Hoy sabe qué hora es: señala la comida que toca ahora, cuánto falta para la siguiente, tu progreso del día (X/N con barra) y la racha 🔥 de días con el plan completo.
Lista de la compra — los checkboxes se guardan en el dispositivo (llévala al súper en el móvil) con contador de carro y botón de reiniciar semana.
Robustez — si Supabase no responde en 5 s, la app arranca igualmente en modo local en vez de quedarse cargando.
Check-in diario — sueño, energía, agujetas y adherencia a dieta → score de readiness 0–100 con gráfica y recomendación (verde: aprieta / ámbar: modera / rojo: Z2 suave).
Otros levantamientos — sentadilla, peso muerto, clean, etc. con e1RM (Epley) para comparar series de distintas reps, gráfica por ejercicio y detección de PRs.
ANÁLISIS — mapa de adherencia de 8 semanas (día a día), tabla de PRs, comparativa de benchmarks repetidos (primera vs última vez), y tabla de tendencias a 4 semanas con lectura automática de cada marcador.
AJUSTES — fecha de inicio del plan (calcula fase y semana en toda la app), peso de referencia ×BW y banda de peso objetivo. Con Supabase, estos parámetros también se sincronizan entre dispositivos.
Archivos
index.html — la web entera (un solo archivo).
supabase-setup.sql — crea la tabla de datos. Sin cambios respecto a v1: la tabla es genérica, así que los nuevos tipos de registro (check-in, levantamientos, parámetros) no requieren tocar el SQL. Si ya la creaste, no hagas nada.
README.md — esto.
Paso 1 · Crear la base de datos (Supabase) · ~5 min
(Si ya lo hiciste con la v1, sáltate este paso: la misma tabla vale.)

Entra en supabase.com → Start your project → crea cuenta.
New project. Elige región cercana (West EU / Frankfurt), pon una contraseña de BD y crea. Espera ~2 min a que provisione.
Menú lateral → SQL Editor → New query → pega todo el contenido de supabase-setup.sql → Run. Debe decir Success.
Project Settings (rueda dentada) → API. Copia dos valores:
Project URL (ej. https://abcd.supabase.co)
anon public key (texto largo que empieza por eyJ...)
Paso 2 · Pegar tus claves en la web
Abre index.html, al inicio del bloque <script> verás:

const SUPABASE_URL = "";        // ← pega tu Project URL
const SUPABASE_ANON_KEY = "";   // ← pega tu anon public key
Pega los dos valores entre las comillas. Guarda.

Al abrir la web verás en HOY, Registros y Ajustes un indicador: ☁ Nube conectada = todo correcto · ● Local = claves sin poner · ⚠ No conecta = revisa que la URL/clave y el SQL estén bien.

Paso 3 · Configurar el plan
Pestaña Ajustes → pon la fecha de inicio (un lunes). Con eso la app calcula la semana actual, la fase, los minutos de Z2 que tocan y marca el día de hoy en la semana tipo.

Paso 4 · Subir a Vercel
Opción fácil (sin instalar nada)

vercel.com → cuenta → New Project.
Arrastra esta carpeta. Framework Preset: Other → Deploy.
Desde terminal

npm i -g vercel
cd plan-carlos
vercel --prod
Vía GitHub — sube la carpeta a un repo, impórtalo en Vercel; cada push actualiza la web.

Uso diario recomendado (2-3 min)
Por la mañana: check-in (sueño, energía, agujetas, dieta de ayer) → HOY te dice si toca apretar o levantar el pie.
Al acabar de entrenar: registra el WOD (o la sesión Z2 con vatios/bpm).
Viernes en ayunas: peso.
Cada 2 semanas (lunes): test 3RM de press — la app avisa cuando toca.
Notas
Respaldo extra: Exportar / Importar JSON (en Registros y Ajustes) aunque uses la nube.
Benchmarks: si registras un WOD con el mismo nombre exacto ("Fran", "Cindy"…) más de una vez, aparece automáticamente la comparativa primera vs última en Análisis.
Seguridad: la clave anon es pública (va en el HTML). La política del SQL es abierta: suficiente para logs de entreno personales. Si quieres acceso solo-tú con login, se añade Supabase Auth — está anotado en supabase-setup.sql.
Cambiar de dispositivo: con Supabase configurado, abres la misma URL en el móvil y ves los mismos datos y los mismos parámetros del plan.
