import Toybox.Attention;
import Toybox.Graphics;
import Toybox.Lang;

(:debug) const LOG = true;
(:debug) const RELEASE = false;
(:debug) const DEBUG = true;
(:debug) const DEBUG_LAYOUT = false;

(:release) const LOG = false;
(:release) const RELEASE = true;
(:release) const DEBUG = false;
(:release) const DEBUG_LAYOUT = false;

const MAX_NUMBER_OF_FIELDS = 32;

const PROPERTY_NUMBER_OF_SESSION_FIELDS = "s";
const PROPERTY_NUMBER_OF_SESSION_FIELDS_DEFAULT = 0;
const PROPERTY_NUMBER_OF_LAP_FIELDS = "l";
const PROPERTY_NUMBER_OF_LAP_FIELDS_DEFAULT = 0;
const PROPERTY_NUMBER_OF_RECORD_FIELDS = "r";
const PROPERTY_NUMBER_OF_RECORD_FIELDS_DEFAULT = 0;
const PROPERTY_FIELD_SIZE = "w";
const PROPERTY_FIELD_SIZE_DEFAULT = 1;
