+uniform mat4 u_Color;
+varying vec2 v_TexCoord;
+varying vec2 v_TexCoord2;
+uniform sampler2D u_Tex0;
+
+const float ALPHA_TOLERANCE = 0.01;
+
+void main() {
+    vec4 baseColor = texture2D(u_Tex0, v_TexCoord);
+    vec4 texcolor = texture2D(u_Tex0, v_TexCoord2);
+
+    int colorIndex = int(texcolor.r > 0.9) + 2 * int(texcolor.g > 0.9) + 3 * int(texcolor.b > 0.9);
+    if (colorIndex > 0) {
+        baseColor *= u_Color[colorIndex - 1];
+    }
+
+    vec4 neighborAlphas = vec4(
+        texture2D(u_Tex0, vec2(v_TexCoord.x + 0.001, v_TexCoord.y)).a,
+        texture2D(u_Tex0, vec2(v_TexCoord.x - 0.001, v_TexCoord.y)).a,
+        texture2D(u_Tex0, vec2(v_TexCoord.x, v_TexCoord.y + 0.001)).a,
+        texture2D(u_Tex0, vec2(v_TexCoord.x, v_TexCoord.y - 0.001)).a
+    );
+
+    bool neighborAlpha = any(greaterThan(neighborAlphas, vec4(ALPHA_TOLERANCE)));
+
+    if (baseColor.a < ALPHA_TOLERANCE && neighborAlpha) {
+        baseColor = vec4(1.0, 0.0, 0.0, 0.7);
+    }
+
+    gl_FragColor = baseColor;
+    if (gl_FragColor.a < ALPHA_TOLERANCE) {
+        discard;
+    }
+}
+)