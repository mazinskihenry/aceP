#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Begins TXA bandaging process
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "TXA"] call aceP_circulation_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_target", "_item", "_medic", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _target getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
private _block = false;

if (_IVactual > 1) then {
    private _randomNumber = random 100;

    if (_IVactual != 4) exitWith {
        if (_randomNumber < GVAR(blockChance)) then {
            _IVarray set [_partIndex, 3];
            _target setVariable [QGVAR(IV), _IVarray, true];
            _block = true;
        };
    };

    _IVarray set [_partIndex, 2];
    _target setVariable [QGVAR(IV), _IVarray, true];
};

[{
    params ["_args", "_idPFH"];
    _args params ["_target"];

    private _bandagedWounds = GET_BANDAGED_WOUNDS(_target);
    private _alive = alive _target;
    private _exit = true;

    private _random = random 750;
    private _ph = (_target getVariable [QGVAR(pH), 1500]) - 750;

    if (_random <= _ph) then {
        {
            private _part = _x;

            if ([_target,_x] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) then {
                continue;
            };

            {
                _x params ["_classID", "_amountOf", "", "_damageOf"];
                private _bandagedWoundsOnPart = _bandagedWounds get _part;
                private _treatedWound = _bandagedWoundsOnPart deleteAt (count _bandagedWoundsOnPart - 1);
                _treatedWound params ["_treatedID", "_treatedAmountOf", "", "_treatedDamageOf"];

                private _stitchedWounds = GET_STITCHED_WOUNDS(_target);
                private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_part, [], true];

                private _woundIndex = _stitchedWoundsOnPart findIf {
                    _x params ["_classID"];
                    _classID == _treatedID
                };

                if (_woundIndex == -1) then {
                    _stitchedWoundsOnPart pushBack _treatedWound;
                } else {
                    private _wound = _stitchedWoundsOnPart select _woundIndex;
                    _wound set [1, (_wound select 1) + _treatedAmountOf];
                };

                _target setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
                _target setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];
                _exit = false;
            } forEach _y;
        } forEach _bandagedWounds;
    };

    if ((!_alive) || (_exit)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

}, 6, [_target]] call CBA_fnc_addPerFrameHandler;
