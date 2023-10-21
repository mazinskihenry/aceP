#include "script_component.hpp"
/*
 * Author: PabstMirror
 * Applies a splint to the patient on the given body part.
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
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_splint
 *
 * Public: No
 */

params ["_patient", "_value"];

if (local _patient) then {
    ["treatmentCoagulation", [_patient, _value]] call CBA_fnc_localEvent;
} else {
    ["treatmentCoagulation", [_patient, _value], _patient] call CBA_fnc_targetEvent;
};
