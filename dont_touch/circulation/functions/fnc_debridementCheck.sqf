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

params ["_medic", "_patient", "_bodyPart", "_number"];

private _debridement = _patient getVariable [QGVAR(debridement), [0,0,0,0,0,0]];
private _compare = ALL_BODY_PARTS find toLower _bodyPart;
private _check = true;

if (_number == 1) then {
    _debridement set [_compare, 1];
    _patient setVariable [QGVAR(debridement), _debridement, true];
};

{
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"];

    if (_bodyPartN == _compare && {_amountOf * _bleeding > 0}) exitWith {
        _check = false;
    };

} forEach GET_OPEN_WOUNDS(_patient);

if (_check) exitWith {true};

false