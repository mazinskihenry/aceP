#include "script_component.hpp"
/*
 * Author: PabstMirror
 * Local callback for applying a splint to a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_splintLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;

private _fractures = GET_FRACTURES(_patient);
_fractures set [_partIndex, -1];
_patient setVariable [VAR_FRACTURES, _fractures, true];

[_patient] call ace_medical_engine_fnc_updateDamageEffects;