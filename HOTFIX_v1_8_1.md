# ARL v1.8.1 shader hotfix

The first v1.8 package had a GLSL function-ordering bug in the new chroma-preserving tone mapper.

Chrome/ANGLE reported:

```
'acesTone' : no matching overloaded function found
'=' : dimension mismatch
'=' : cannot convert from 'const mediump float' to 'highp 3-component vector of float'
```

Root cause: `chromaTone()` called `acesTone()` before GLSL had seen a declaration/definition for `acesTone`.

v1.8.1 fixes this by declaring the function before first use and defining it before `chromaTone()` is compiled.

No renderer design was rolled back. The v1.8 multi-scale GI changes remain intact.
