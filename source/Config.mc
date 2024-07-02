import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.System;

function setConfig(key as PropertyKeyType, val as PropertyValueType) as Void {
    if (Application has :Properties) {
        Properties.setValue(key, val);
    } else {
        getApp().setProperty(key, val);
    }
}

(:inline)
function getConfigImpl(key as PropertyKeyType) as PropertyValueType or Null {
    var val;
    if (Application has :Properties) {
        val = Properties.getValue(key);
    } else {
        val = getApp().getProperty(key);
    }
    return val;
}
(:no_inline) // no_inline:-59
function getConfig(key as PropertyKeyType) as PropertyValueType or Null {
    var val;
    try {
        val = getConfigImpl(key);
    } catch (e) { // adds 31 bytes (non optimized)
        errorRelease(key + ":" + e.getErrorMessage());
        val = null;
    }
    // logFree("gC");
    return val;
}

(:background_app, :no_inline) // i: code: 15858 data: 6808 n: code: 15829 data: 6835 = -29+27=-2
function getConfigNumber(key as PropertyKeyType, defaultValue as Number) as Number {
    return toConfigNumber(getConfig(key), defaultValue);
}
(:background_app, :no_inline)
function toConfigNumber(value as PropertyValueType?, defaultValue as Number) as Number {
    // if (value instanceof Lang.Number) {
    //     return value;
    // }
    // if (value != null && value has :toNumber) {
    //     value = (value as ConvertibleToNumber).toNumber();
    // }
    // value = value != null && value has :toNumber ? (value as ConvertibleToNumber).toNumber() : null;
    if (value instanceof Lang.Boolean) {
        return value ? 1 : 0;
    }
    // this should cover Float, Double, Number, String, Long, Char, Symbol
    value = value != null && value has :toNumber ? value.toNumber() : null;
    return value != null ? value as Number : defaultValue;
}
