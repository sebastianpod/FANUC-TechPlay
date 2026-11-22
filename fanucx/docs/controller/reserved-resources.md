# Reserved Controller Resources

FanucX Motion uses dedicated FANUC Position Registers and Numeric Registers to exchange motion requests and status information between `FX_SERVER` and `FXMOTION`.

These resources are reserved for FanucX and must not be used by unrelated TP programs, KAREL programs, PLC logic, background logic, macros, or external applications.

---

## Reserved resources

| Resource | Purpose | Written by | Read by |
|---|---|---|---|
| `PR[90]` | Motion request target prepared by `FX_SERVER` | `FX_SERVER` | FanucX Motion execution logic |
| `PR[93]` | Motion execution target used by `FXMOTION` | `FXMOTION` | `FXMOTION` motion instruction |
| `R[191]` | Motion type | `FX_SERVER` | `FXMOTION`, status operations |
| `R[192]` | Motion Group number | `FX_SERVER` | `FXMOTION`, status operations |
| `R[193]` | Motion speed | `FX_SERVER` | `FXMOTION` |
| `R[194]` | Motion termination value | `FX_SERVER` | `FXMOTION` |
| `R[195]` | Motion status | `FX_SERVER`, `FXMOTION`, abort logic | `FX_SERVER`, Python Motion API |
| `R[196]` | Motion result | `FX_SERVER`, `FXMOTION`, abort logic | `FX_SERVER`, Python Motion API |
| `R[197]` | Motion error | `FX_SERVER`, `FXMOTION`, abort logic | `FX_SERVER`, Python Motion API |
| `R[198]` | User Frame number | `FX_SERVER` | `FXMOTION` |
| `R[199]` | Tool Frame number | `FX_SERVER` | `FXMOTION` |

---

## Position Registers

### `PR[90]` — request target

`FX_SERVER` writes the validated motion target to `PR[90]` before starting `FXMOTION`.

The register can contain either:

- a Cartesian target without extended axes, or
- a Joint target containing exactly six axes.

The representation depends on the target supplied to `movej()` or `movel()`.

Do not modify `PR[90]` while a FanucX Motion request is being prepared or executed.

### `PR[93]` — execution target

`FXMOTION` uses `PR[93]` as its execution target.

Keeping the execution target separate from the request target prevents a new request value from directly changing the position currently used by the TP Motion instruction.

Do not modify `PR[93]` while `FXMOTION` is running.

---

## Motion request registers

### `R[191]` — Motion type

| Value | Meaning |
|---:|---|
| `0` | No Motion type |
| `1` | Joint Motion |
| `2` | Linear Motion |

`FX_SERVER` writes this register before setting the Motion status to Accepted.

### `R[192]` — Motion Group

Contains the Motion Group number associated with the current FanucX Motion request.

The current Motion executor supports Motion Group 1.

### `R[193]` — speed

Contains the requested Motion speed.

Its unit depends on `R[191]`:

| Motion type | Speed unit |
|---|---|
| Joint | Percentage, `1-100` |
| Linear | `mm/sec`, positive integer |

### `R[194]` — termination

Contains the controller-side termination value:

| Value | Meaning |
|---:|---|
| `-1` | `FINE` |
| `0-100` | `CNT0` through `CNT100` |

### `R[198]` — User Frame

Contains the User Frame number used for Motion execution.

```text
0 = World Frame
```

A positive value identifies a configured User Frame.

### `R[199]` — Tool Frame

Contains the Tool Frame number used for Motion execution.

```text
0 = Tool Frame origin at the robot faceplate
```

A positive value identifies a configured Tool Frame.

---

## Motion state registers

### `R[195]` — Motion status

| Value | Meaning |
|---:|---|
| `0` | Idle |
| `1` | Accepted |
| `2` | Running |
| `3` | Completed |
| `4` | Failed |
| `5` | Aborted |
| `6` | Rejected |

`R[195]` is the synchronization field for FanucX Motion.

When starting a Motion, `FX_SERVER` writes all request data first and writes status `1` last. This ensures that `FXMOTION` does not observe an Accepted request before the remaining request fields are ready.

When completing, failing, aborting, or rejecting a Motion, the result and error registers are updated before the final status is written.

### `R[196]` — Motion result

| Value | Meaning |
|---:|---|
| `0` | No successful result |
| `1` | Motion completed successfully |

A completed Motion normally reports:

```text
R[195] = 3
R[196] = 1
R[197] = 0
```

An aborted Motion reports:

```text
R[195] = 5
R[196] = 0
R[197] = 0
```

### `R[197]` — Motion error

Contains `0` when no Motion error is recorded.

A nonzero value contains a FanucX or controller status associated with a failed, rejected, or unsuccessfully aborted Motion.

The meaning of controller-originated status values depends on the controller software and installed options. Refer to the official FANUC documentation applicable to the controller version in use.

---

## Request update order

`FX_SERVER` prepares a Motion request in the following order:

1. Validate the target, Motion Group, frames, speed, and termination
2. Write the target to `PR[90]`
3. Write `R[191]`, `R[192]`, `R[193]`, and `R[194]`
4. Clear `R[196]` and `R[197]`
5. Write `R[198]` and `R[199]`
6. Write `R[195] = 1` as the final request field
7. Start `FXMOTION`

The ordering is part of the synchronization between the KAREL server and the TP Motion executor.

---

## Resource ownership rules

While a FanucX Motion is Accepted or Running, no other controller or external logic may write to:

```text
PR[90]
PR[93]
R[191]-R[199]
```

This restriction applies to:

- TP programs,
- KAREL programs,
- Background Logic,
- PMC or PLC logic,
- macros,
- HMI applications,
- OPC or fieldbus clients,
- other Python or network applications,
- manual register editing from the teach pendant.

Concurrent modification can change the target, frame, speed, termination, result, error, or state observed by FanucX.

---

## Installation check

Before enabling FanucX Motion:

1. Open the Numeric Register and Position Register tables
2. Confirm that `PR[90]`, `PR[93]`, and `R[191]-R[199]` are not used by the existing controller project
3. Check TP programs, KAREL programs, Background Logic, PLC mappings, macros, and external interfaces
4. Add comments identifying the resources as reserved for FanucX
5. Test Motion first in RoboGuide

Suggested comments:

| Resource | Suggested comment |
|---|---|
| `PR[90]` | `FX REQUEST TARGET` |
| `PR[93]` | `FX MOTION TARGET` |
| `R[191]` | `FX MOT TYPE` |
| `R[192]` | `FX MOT GROUP` |
| `R[193]` | `FX MOT SPEED` |
| `R[194]` | `FX MOT TERM` |
| `R[195]` | `FX MOT STATUS` |
| `R[196]` | `FX MOT RESULT` |
| `R[197]` | `FX MOT ERROR` |
| `R[198]` | `FX UFRAME` |
| `R[199]` | `FX UTOOL` |

Controller comment-length limits may require shorter labels.

---

## Changing the reserved resource numbers

The resource numbers are currently part of the FanucX controller implementation. Changing them requires consistent updates in all locations that reference them, including:

- `FX_SERVER.KL` and the relevant KAREL include files,
- `FXMOTION.LS`,
- controller comments and commissioning records,
- this document,
- any tests or diagnostic tools that inspect the Motion registers.

Do not change only one side of the KAREL-to-TP interface. Mismatched register assignments can cause incorrect Motion execution or invalid Motion status reporting.

---

## Safety limitation

Reserved registers are an internal communication mechanism. They are not safety-rated and do not provide mutual exclusion against unrelated controller logic.

Resource reservation does not replace:

- DCS,
- collision detection,
- guarding,
- emergency-stop circuits,
- enabling devices,
- safety PLC logic,
- controller safety logic,
- commissioning and machine risk assessment.
