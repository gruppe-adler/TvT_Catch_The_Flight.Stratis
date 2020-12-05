#define MISSION_PASSPORT_AT_PADDING_X           (0.115 * X_SCALE)
#define MISSION_PASSPORT_AT_LEFTCOLUMN_X        (GRAD_PASSPORT_DEFAULT_X + MISSION_PASSPORT_AT_PADDING_X)
#define MISSION_PASSPORT_AT_TEXT_COLOR          {0.3,0.3,0.3,1}
#define MISSION_PASSPORT_AT_TEXT_SIZE           (0.025 * TEXT_SCALE)

class grad_passport_at: grad_passport_defaultPassport {
    class ControlsBackground: ControlsBackground {
        class BGPic: BGPic {
            text = "ui\austrian_id_card_blank.paa";
        };
    };
	class Controls: Controls {
		// delete PlaceOfBirthTitle;
		// delete ExpiresTitle;
		// delete LastNameTitle;
		// delete FirstNameTitle;
		// delete DateOfBirthTitle;

        class Serial: Serial {
            x = (MISSION_PASSPORT_AT_LEFTCOLUMN_X + GRAD_PASSPORT_DEFAULT_INDENT_X);
            y = GRAD_PASSPORT_DEFAULT_LINE_Y(0);
            w = GRAD_PASSPORT_CONTENT_W;
            h = GRAD_PASSPORT_LINE_H;

            font = "EtelkaMonospacePro";
            sizeEx = MISSION_PASSPORT_AT_TEXT_SIZE;
            colorText[] = MISSION_PASSPORT_AT_TEXT_COLOR;
        };

		class LastName: LastName {
			x = (MISSION_PASSPORT_AT_LEFTCOLUMN_X + GRAD_PASSPORT_DEFAULT_INDENT_X);
			y = GRAD_PASSPORT_DEFAULT_LINE_Y(1);
			font = "EtelkaMonospacePro";
			colorText[] = MISSION_PASSPORT_AT_TEXT_COLOR;
			sizeEx = MISSION_PASSPORT_AT_TEXT_SIZE;
       };

       class FirstName: FirstName {
			x = (MISSION_PASSPORT_AT_LEFTCOLUMN_X + GRAD_PASSPORT_DEFAULT_INDENT_X);
			y = GRAD_PASSPORT_DEFAULT_LINE_Y(1.5);
			font = "EtelkaMonospacePro";
			colorText[] = MISSION_PASSPORT_AT_TEXT_COLOR;
			sizeEx = MISSION_PASSPORT_AT_TEXT_SIZE;
		};
		class DateOfBirth: DateOfBirth {
			x = (MISSION_PASSPORT_AT_LEFTCOLUMN_X + GRAD_PASSPORT_DEFAULT_INDENT_X);
			y = GRAD_PASSPORT_DEFAULT_LINE_Y(2.6);
			font = "EtelkaMonospacePro";
			colorText[] = MISSION_PASSPORT_AT_TEXT_COLOR;
			sizeEx = MISSION_PASSPORT_AT_TEXT_SIZE;
       	};
	};
};
