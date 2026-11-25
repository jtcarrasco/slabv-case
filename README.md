# slabv-case

A 3D-printable bottom tray for the [slabV](https://github.com/brickbots/slabv) keyboard by brickbots. It replaces the acrylic bottom plate; the PCB, acrylic mid and top plates and the standoffs stay as in the original design.

Made for a wireless build (nice!nano, firmware in [slabv-zmk](https://github.com/jtcarrasco/slabv-zmk)): there is room under the PCB for a 3mm LiPo and a slide switch.

**Status: draft 1, not printed yet.** Print `slabv_tray_test.stl` (one corner with a screw boss) and check the fit before the full tray.

## Files

- `slabv_tray.scad`: the model (OpenSCAD). All sizes are parameters at the top.
- `slabv_tray.stl`: full tray, 229.6 x 92.9 x 7.1 mm. Fits a 256mm bed flat.
- `slabv_tray_test.stl`: fit-test corner.
- `slabv_outline.dxf`: board outline, the outer edge of the upstream `case/slabv_bot.dxf`.

Rebuild the STLs: `openscad -o slabv_tray.stl slabv_tray.scad` and `openscad -D 'part="test"' -o slabv_tray_test.stl slabv_tray.scad`.

## Fit

- PCB sits on 12 bosses, 3.5mm above the floor (clears diodes, pins and Mill-Max socket tails). 0.4mm gap to the wall; rim is flush with the PCB top.
- 12 x M2x5 screws from below into the 3mm female/female standoffs. 1.5mm of plastic stays under each screw head, standing in for the 1.6mm acrylic bottom.
- Battery pocket (301230 cell) between the controller header rows, slide switch (SS12D00 size) at the back beside the USB notch, lever into the notch, wire slot at the top notch.

## Tilt

The tray is flat on purpose. Set the angle with rubber feet: taller feet at the back for a normal tilt, or at the front for a negative tilt. Keep feet clear of the 12 screw recesses on the underside.

## Printing

PETG or PLA, 0.2mm layers, floor down. The switch lever slot may need a small support.

## License

MIT. The outline and screw positions come from brickbots/slabv (MIT, Copyright (c) 2021 Richard Sutherland).
