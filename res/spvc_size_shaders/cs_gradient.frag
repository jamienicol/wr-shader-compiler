#version 300 es
precision mediump float;
precision highp int;

flat in highp vec4 vColor0;
flat in highp vec4 vColor1;
flat in highp vec4 vStops;
in highp float vPos;
flat in highp vec4 vColor2;
flat in highp vec4 vColor3;
layout(location = 0) out highp vec4 oFragColor;

void main()
{
    highp float _164;
    switch (0u)
    {
        default:
        {
            if (vStops.x >= vStops.y)
            {
                _164 = 0.0;
                break;
            }
            _164 = clamp((vPos - vStops.x) / (vStops.y - vStops.x), 0.0, 1.0);
            break;
        }
    }
    highp float _165;
    switch (0u)
    {
        default:
        {
            if (vStops.y >= vStops.z)
            {
                _165 = 0.0;
                break;
            }
            _165 = clamp((vPos - vStops.y) / (vStops.z - vStops.y), 0.0, 1.0);
            break;
        }
    }
    highp float _166;
    switch (0u)
    {
        default:
        {
            if (vStops.z >= vStops.w)
            {
                _166 = 0.0;
                break;
            }
            _166 = clamp((vPos - vStops.z) / (vStops.w - vStops.z), 0.0, 1.0);
            break;
        }
    }
    oFragColor = mix(mix(mix(vColor0, vColor1, vec4(_164)), vColor2, vec4(_165)), vColor3, vec4(_166));
}

