import Toybox.Lang;
using Toybox.FitContributor as Fit;
import Toybox.FitContributor;
import Toybox.WatchUi;

class FitFieldWasterFitContributor {

    private var mNumberOfSessionFields as Number = 0;
    private var mSessionFields as Array<Field?>;
    private var mNumberOfLapFields as Number = 0;
    private var mLapFields as Array<Field?>;
    private var mNumberOfRecordFields as Number = 0;
    private var mRecordFields as Array<Field?>;

    private var mFieldSize as Number;
    private var mFieldType as Fit.DataType;

    public function initialize(dataField as SimpleDataField) {
        mSessionFields = new Field[MAX_NUMBER_OF_FIELDS];

        mLapFields = new Field[MAX_NUMBER_OF_FIELDS];

        mRecordFields = new Field[MAX_NUMBER_OF_FIELDS];

        mFieldSize = getConfigNumber(PROPERTY_FIELD_SIZE, PROPERTY_FIELD_SIZE_DEFAULT);
        switch (mFieldSize) {
            case 2: mFieldType = Fit.DATA_TYPE_UINT16; break;
            case 4: mFieldType = Fit.DATA_TYPE_UINT32; break;
            case 1:
            default:
                mFieldType = Fit.DATA_TYPE_UINT8; break;
        }
        onSettingsChanged(dataField);
    }

    public function onSettingsChanged(dataField as SimpleDataField) as Void {
        var numberOfSessionFields = getConfigNumber(PROPERTY_NUMBER_OF_SESSION_FIELDS, PROPERTY_NUMBER_OF_SESSION_FIELDS_DEFAULT);
        if (numberOfSessionFields > mNumberOfSessionFields) {
            for (var f = mNumberOfSessionFields; f < numberOfSessionFields; ++f) {
                var field = dataField.createField("session_field_" + f, f + 0 * MAX_NUMBER_OF_FIELDS, mFieldType, { :mesgType=>Fit.MESG_TYPE_SESSION });
                field.setData(f);
                mSessionFields[f] = field;
            }
            mNumberOfSessionFields = numberOfSessionFields;
        }

        var numberOfLapFields = getConfigNumber(PROPERTY_NUMBER_OF_LAP_FIELDS, PROPERTY_NUMBER_OF_LAP_FIELDS_DEFAULT);
        if (numberOfLapFields > mNumberOfLapFields) {
            for (var f = mNumberOfLapFields; f < numberOfLapFields; ++f) {
                var field = dataField.createField("lap_field_" + f, f + 1 * MAX_NUMBER_OF_FIELDS, mFieldType, { :mesgType=>Fit.MESG_TYPE_LAP });
                field.setData(f);
                mLapFields[f] = field;
            }
            mNumberOfLapFields = numberOfLapFields;
        }

        var numberOfRecordFields = getConfigNumber(PROPERTY_NUMBER_OF_RECORD_FIELDS, PROPERTY_NUMBER_OF_RECORD_FIELDS_DEFAULT);
        if (numberOfRecordFields > mNumberOfRecordFields) {
            for (var f = mNumberOfRecordFields; f < numberOfRecordFields; ++f) {
                var field = dataField.createField("record_field_" + f, f + 2 * MAX_NUMBER_OF_FIELDS, mFieldType, { :mesgType=>Fit.MESG_TYPE_RECORD });
                field.setData(f);
                mRecordFields[f] = field;
            }
            mNumberOfRecordFields = numberOfRecordFields;
        }
    }

    public function setData() as String {
        for (var f = 0; f < mNumberOfRecordFields; ++f) {
            var field = mRecordFields[f];
            if (field != null) {
                field.setData(f);
            }
        }
        var totalSize = (mNumberOfSessionFields + mNumberOfLapFields + mNumberOfRecordFields) * mFieldSize;
        return "(S:" + mNumberOfSessionFields + ", L:" + mNumberOfLapFields + ", R:" + mNumberOfRecordFields + ") * " + mFieldSize + " = " + totalSize + " bytes";
    }

    public function onTimerLap() as Void {
        for (var f = 0; f < mNumberOfLapFields; ++f) {
            var field = mLapFields[f];
            if (field != null) {
                field.setData(f);
            }
        }
    }
}
