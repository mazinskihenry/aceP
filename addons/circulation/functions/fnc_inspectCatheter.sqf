#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_fractureCheck;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;

if (_IVactual == 3) exitWith {
    private _output = localize LSTRING(IVblock_closed);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

private _output = localize LSTRING(IVblock_clear);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;