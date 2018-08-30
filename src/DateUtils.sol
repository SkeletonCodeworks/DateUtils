pragma solidity ^0.4.24;

import "./strings.sol";
import "./StringUtils.sol";

/**
 @title Date utility library for Solidity contracts
 @author Skeleton Codeworks, LLC <skeleton.codeworks@gmail.com>

 @dev This library primarily provides utilities to convert between various
      date and time formats.  The supported formats are: 1) Unix timestamps,
      2) strings in yyyy-mm-dd format (also known as ISO), and
      3) YMD format (year, month, day, as integers).

      Additionally, support is provided for the date and time formats
      analogous to the date formats above: 1) Unix timestamps (identical to
      the format above), 2) strings in yyyy-mm-dd hh:mm:ss format, and
      3) YMDHMS format (year, month, day, hour, minute, second, as integers).
      Hours, minutes, and seconds are in 24-hour clock format (i.e., hour
      from 0 - 23, minute from 0 - 59, and second from 0 - 59).

      Convenience functions for validation, splitting date strings, and
      calculating the day of the week are also provided.

      Note that this library does not use "yyyy-mm-ddThh:mm:ssZ" as valid
      date and time format, but rather "yyyy-mm-dd hh:mm:ss".
*/

library DateUtils {

   using strings for *;
   using StringUtils for *;

   uint256 constant SECONDS_IN_MINUTE = 60;
   uint256 constant SECONDS_IN_HOUR = 3600;
   uint256 constant SECONDS_IN_DAY = 86400;
   uint256 constant SECONDS_IN_YEAR = 31536000;
   uint256 constant SECONDS_IN_FOUR_YEARS_WITH_LEAP_YEAR = 126230400;
   uint256 constant SECONDS_BETWEEN_JAN_1_1972_AND_DEC_31_1999 = 883612800;
   uint256 constant SECONDS_IN_100_YEARS = 3155673600;
   uint256 constant SECONDS_IN_400_YEARS = 12622780800;

   // functions to validate inputs
   function isValidYear(uint16 _year) private pure returns (bool) {

     if ((_year < 1970) || (_year > 9999)) { return false; }
     return true;
   }

   function isValidMonth(uint8 _month) private pure returns (bool) {

     if ((_month < 1) || (_month > 12)) { return false; }
     return true;
   }

   function isValidDay(uint16 _year,
                       uint8 _month,
                       uint8 _day)
                       private pure
                       returns (bool) {

     uint8[13] memory monthDayMap = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
     uint8 daysInMonth;

     if (_day == 0) { return false; }

     if (_month == 2) {

       if (isLeapYear(_year)) {
         daysInMonth = 29;
       } else {
         daysInMonth = 28;
       }

     } else {
       daysInMonth = monthDayMap[_month];
     }

     if (_day > daysInMonth) { return false; }

     return true;
   }

   function isValidHour(uint8 _hour) private pure returns (bool) {

     if (_hour > 23) { return false; }
     return true;
   }

   function isValidMinute(uint8 _min) private pure returns (bool) {

     if (_min > 59) { return false; }
     return true;
   }

   function isValidSecond(uint8 _sec) private pure returns (bool) {

     if (_sec > 59) { return false; }
     return true;
   }

   /**
    @dev Check valid YMD (year, month, day)
    @param _y Year as integer; must be >= 1970 and <= 9999
    @param _m Month as integer; must be >= 1 and <= 12
    @param _d Day as integer; must be >= 1 and <= 31
    @return Returns `true` if all inputs are valid, `false` otherwise
   */
   function isValidYMD(uint16 _y,
                       uint8 _m,
                       uint8 _d)
                       internal pure
                       returns (bool) {

     if (!isValidYear(_y)) { return false; }
     if (!isValidMonth(_m)) { return false; }
     if (!isValidDay(_y, _m, _d)) { return false; }
     return true;
   }

   /**
    @dev Check valid YMDHMS (year, month, day, hour, minute, second)
    @param _y Year as integer; must be >= 1970 and <= 9999
    @param _m Month as integer; must be >= 1 and <= 12
    @param _d Day as integer; must be >= 1 and <= 31
    @param _h Hour as integer; must be >= 0 and <= 23
    @param _min Minute as integer; must be >= 0 and <= 59
    @param _s Second as integer; must be >= 0 and <= 59
    @return Returns `true` if all inputs are valid, `false` otherwise
   */
   function isValidYMDHMS(uint16 _y,
                          uint8 _m,
                          uint8 _d,
                          uint8 _h,
                          uint8 _min,
                          uint8 _s)
                          internal pure
                          returns (bool) {

     if (!isValidYear(_y)) { return false; }
     if (!isValidMonth(_m)) { return false; }
     if (!isValidDay(_y, _m, _d)) { return false; }
     if (!isValidHour(_h)) { return false; }
     if (!isValidMinute(_min)) { return false; }
     if (!isValidSecond(_s)) { return false; }
     return true;
   }

   // functions to convert between string slice objects and integers
   function convertSliceToUint16(strings.slice s) private pure returns (uint16) {

     bytes32 digits;
     digits = StringUtils.stringToBytes32(s.toString());

     return uint16(StringUtils.bytesToUInt(digits));
   }

   function convertSliceToUint8(strings.slice s) private pure returns (uint8) {

     bytes32 digits;
     digits = StringUtils.stringToBytes32(s.toString());

     return uint8(StringUtils.bytesToUInt(digits));
   }

   // functions to split date strings into component slice objects
   function splitISOslice(string _dt) private pure returns (strings.slice[3]) {

     strings.slice[3] memory sArr;

     strings.slice memory sDate = _dt.toSlice();
     strings.slice memory sHyphen = "-".toSlice();

     sArr[0] = sDate.split(sHyphen);
     sArr[1] = sDate.split(sHyphen);
     sArr[2] = sDate;

     return sArr;
   }

   function splitTimeSlice(string _time) private pure returns (strings.slice[3]) {

     strings.slice[3] memory sArr;

     strings.slice memory sTime = _time.toSlice();
     strings.slice memory sColon = ":".toSlice();

     sArr[0] = sTime.split(sColon);
     sArr[1] = sTime.split(sColon);
     sArr[2] = sTime;

     return sArr;
   }

   /**
    @dev Split time string (ISO format) into hour, minute, second integers
    @param _time Time as hh:mm:ss string
    @return hour Returns hour as `uint8`
    @return minute Returns minute as `uint8`
    @return second Returns second as `uint8`
   */
   function splitTimeInt(string _time)
                         internal pure
                         returns (uint8 hour,
                                  uint8 minute,
                                  uint8 second) {

     require(isTimeFormat(_time));

     strings.slice[3] memory sArr = splitTimeSlice(_time);
     strings.slice memory sHour = sArr[0];
     strings.slice memory sMinute = sArr[1];
     strings.slice memory sSecond = sArr[2];

     hour = convertSliceToUint8(sHour);
     minute = convertSliceToUint8(sMinute);
     second = convertSliceToUint8(sSecond);
   }

   /**
    @dev Check valid ISO date string format ("yyyy-mm-dd")
    @param _dt Date as string
    @return Returns `true` if `_dt` is valid ISO format, `false` otherwise
   */
   function isISOformat(string _dt) internal pure returns (bool) {

     strings.slice memory sDate = _dt.toSlice();
     strings.slice memory sHyphen = "-".toSlice();
     strings.slice memory sYear;
     strings.slice memory sMonth;
     strings.slice memory sDay;
     strings.slice[3] memory sArr;
     uint16 year;
     uint8 month;
     uint8 day;

     if (sDate.len() != 10) { return false; }
     if (strings.count(sDate, sHyphen) != 2) { return false; }

     sArr = splitISOslice(_dt);
     sYear = sArr[0];
     sMonth = sArr[1];
     sDay = sArr[2];

     if (sYear.len() != 4) { return false; }
     year = convertSliceToUint16(sYear);

     if (sMonth.len() != 2) { return false; }
     month = convertSliceToUint8(sMonth);
     if (!isValidMonth(month)) { return false; }

     if (sDay.len() != 2) { return false; }
     day = convertSliceToUint8(sDay);
     if (!isValidDay(year, month, day)) { return false; }

     return true;
   }

   // check valid time format (hh:mm:ss)
   function isTimeFormat(string _time) private pure returns (bool) {

     strings.slice memory sTime = _time.toSlice();
     strings.slice memory sColon = ":".toSlice();
     strings.slice memory sHour;
     strings.slice memory sMinute;
     strings.slice memory sSecond;
     strings.slice[3] memory sArr;
     uint8 hour;
     uint8 minute;
     uint8 second;

     if (sTime.len() != 8) { return false; }
     if (strings.count(sTime, sColon) != 2) { return false; }

     sArr = splitTimeSlice(_time);
     sHour = sArr[0];
     sMinute = sArr[1];
     sSecond = sArr[2];

     if (sHour.len() != 2) { return false; }
     hour = convertSliceToUint8(sHour);
     if (!isValidHour(hour)) { return false; }

     if (sMinute.len() != 2) { return false; }
     minute = convertSliceToUint8(sMinute);
     if (!isValidMinute(minute)) { return false; }

     if (sSecond.len() != 2) { return false; }
     second = convertSliceToUint8(sSecond);
     if (!isValidSecond(second)) { return false; }

     return true;
   }

   /**
    @dev Check valid date and time string format ("yyyy-mm-dd hh:mm:ss")
    @param _dt Date and time as string
    @return Returns `true` if `_dt` is valid yyyy-mm-dd hh:mm:ss format,
            `false` otherwise
   */
   function isISOtimeFormat(string _dt) internal pure returns (bool) {

     strings.slice memory sDate = _dt.toSlice();
     strings.slice memory sSpace = " ".toSlice();
     strings.slice memory sISO;

     if (sDate.len() != 19) { return false; }

     sISO = sDate.split(sSpace);
     if (!isISOformat(sISO.toString())) { return false; }
     if (!isTimeFormat(sDate.toString())) { return false; }

     return true;
   }

   /**
    @dev Check if year is a leap year
    @param _year Year as integer
    @return Returns `true` if `_year` is a leap year, `false` otherwise
   */
   function isLeapYear(uint16 _year) internal pure returns (bool) {

     if ((_year % 4) != 0) { return false; }
     if (((_year % 400) == 0) || ((_year % 100) != 0)) { return true; }

     return false;
   }

   /**
    @dev Get day of the week of a timestamp
    @param _timestamp Timestamp as integer
    @return Returns day of the week as `uint8` (0 is Sunday,
            and 6 is Saturday)
   */
   function getWeekday(uint256 _timestamp) internal pure returns (uint8) {
     return uint8((_timestamp / SECONDS_IN_DAY + 4) % 7);
   }

   // function to get total seconds in year
   function getSecondsInYear(uint16 _year) private pure returns (uint256) {

     if (isLeapYear(_year)) {
       return (SECONDS_IN_YEAR + SECONDS_IN_DAY);
     } else {
       return SECONDS_IN_YEAR;
     }
   }

   // functions to calculate year, month, or day from timestamp
   function getYear(uint256 _secondsRemaining)
                    private pure
                    returns (uint256 secondsRemaining,
                             uint16 year) {

     uint256 res;
     uint32 secondsInThisYear;

     secondsRemaining = _secondsRemaining;
     year = 1970;

     if (secondsRemaining < (2 * SECONDS_IN_YEAR)) {

       res = secondsRemaining / SECONDS_IN_YEAR;
       secondsRemaining -= res * SECONDS_IN_YEAR;
       year += uint16(res);

     } else {

       secondsRemaining -= 2 * SECONDS_IN_YEAR;
       year = 1972;

       if (secondsRemaining >= SECONDS_BETWEEN_JAN_1_1972_AND_DEC_31_1999) {

         secondsRemaining -= SECONDS_BETWEEN_JAN_1_1972_AND_DEC_31_1999;
         year += 28;

         res = secondsRemaining / SECONDS_IN_400_YEARS;
         secondsRemaining -= res * SECONDS_IN_400_YEARS;
         year += uint16(res * 400);

         secondsInThisYear = uint32(getSecondsInYear(year));

         if (secondsRemaining >= secondsInThisYear) {

           secondsRemaining -= secondsInThisYear;
           year += 1;
         }

         if (!isLeapYear(year)) {

           res = secondsRemaining / SECONDS_IN_100_YEARS;
           secondsRemaining -= res * SECONDS_IN_100_YEARS;
           year += uint16(res * 100);
         }
       }

       res = secondsRemaining / SECONDS_IN_FOUR_YEARS_WITH_LEAP_YEAR;
       secondsRemaining -= res * SECONDS_IN_FOUR_YEARS_WITH_LEAP_YEAR;
       year += uint16(res * 4);

       secondsInThisYear = uint32(getSecondsInYear(year));

       if (secondsRemaining >= secondsInThisYear) {

         secondsRemaining -= secondsInThisYear;
         year += 1;
       }

       if (!isLeapYear(year)) {

         res = secondsRemaining / SECONDS_IN_YEAR;
         secondsRemaining -= res * SECONDS_IN_YEAR;
         year += uint16(res);
       }
     }
   }

   function getMonth(uint256 _secondsRemaining,
                     uint16 _year)
                     private pure
                     returns (uint256 secondsRemaining,
                              uint8 month) {

     uint8[13] memory monthDayMap;
     uint32[13] memory monthSecondsMap;

     secondsRemaining = _secondsRemaining;

     if (isLeapYear(_year)){

       monthDayMap = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
       monthSecondsMap = [0, 2678400, 5184000, 7862400, 10454400, 13132800,
                          15724800, 18403200, 21081600, 23673600, 26352000,
                          28944000, 31622400];

     } else {

       monthDayMap = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
       monthSecondsMap = [0, 2678400, 5097600, 7776000, 10368000, 13046400,
                          15638400, 18316800, 20995200, 23587200, 26265600,
                          28857600, 31536000];
     }

     for (uint8 i = 1; i < 13; i++) {

       if (secondsRemaining < monthSecondsMap[i]) {

         month = i;
         secondsRemaining -= monthSecondsMap[i - 1];
         break;
       }
     }
   }

   function getDay(uint256 _secondsRemaining)
                   private pure
                   returns (uint256 secondsRemaining,
                            uint8 day) {

     uint256 res;

     secondsRemaining = _secondsRemaining;

     res = secondsRemaining / SECONDS_IN_DAY;
     secondsRemaining -= res * SECONDS_IN_DAY;
     day = uint8(res + 1);
   }

   // functions to increment timestamp based on year
   function incrementYearAndTimestamp(uint16 _year,
                                      uint16 _yearCounter,
                                      uint256 _ts,
                                      uint16 _divisor,
                                      uint256 _seconds)
                                      private pure
                                      returns (uint16 year,
                                               uint256 ts) {

     uint256 res;

     res = uint256((_year - _yearCounter) / _divisor);
     year = uint16(_yearCounter + (res * _divisor));
     ts = _ts + (res * _seconds);
   }

   function incrementLeapYear(uint16 _year,
                              uint16 _yearCounter,
                              uint256 _ts)
                              private pure
                              returns (uint16 yearCounter,
                                       uint256 ts) {

     yearCounter = _yearCounter;
     ts = _ts;

     if ((yearCounter < _year) && isLeapYear(yearCounter)) {

       yearCounter += 1;
       ts += SECONDS_IN_YEAR + SECONDS_IN_DAY;
     }
   }

   // add years or months in seconds to timestamps
   function addYearSeconds(uint256 _ts,
                           uint16 _year)
                           private pure
                           returns (uint256) {

     uint16 yearCounter;
     uint256 ts = _ts;

     if (_year < 1972) {

       ts += (_year - 1970) * SECONDS_IN_YEAR;

     } else {

       ts += 2 * SECONDS_IN_YEAR;
       yearCounter = 1972;

       if (_year >= 2000) {

         ts += SECONDS_BETWEEN_JAN_1_1972_AND_DEC_31_1999;
         yearCounter = 2000;

         (yearCounter, ts) = incrementYearAndTimestamp(_year, yearCounter, ts,
                                                       400, SECONDS_IN_400_YEARS);
         (yearCounter, ts) = incrementLeapYear(_year, yearCounter, ts);
         (yearCounter, ts) = incrementYearAndTimestamp(_year, yearCounter, ts,
                                                       100, SECONDS_IN_100_YEARS);
       }

       (yearCounter, ts) = incrementYearAndTimestamp(_year, yearCounter, ts,
                                                     4, SECONDS_IN_FOUR_YEARS_WITH_LEAP_YEAR);
       (yearCounter, ts) = incrementLeapYear(_year, yearCounter, ts);
       (yearCounter, ts) = incrementYearAndTimestamp(_year, yearCounter, ts,
                                                     1, SECONDS_IN_YEAR);
     }

     return ts;
   }

   function addMonthSeconds(uint16 _year,
                            uint8 _month)
                            private pure
                            returns (uint256) {

     uint32[13] memory monthSecondsMap;

     if (isLeapYear(_year)){
       monthSecondsMap = [0, 2678400, 5184000, 7862400, 10454400, 13132800,
                          15724800, 18403200, 21081600, 23673600, 26352000,
                          28944000, 31622400];
     } else {
       monthSecondsMap = [0, 2678400, 5097600, 7776000, 10368000, 13046400,
                          15638400, 18316800, 20995200, 23587200, 26265600,
                          28857600, 31536000];
     }

     return uint256(monthSecondsMap[_month - 1]);
   }

   // convert YMD to slice array
   function YMDuintToBytes(uint16 _y,
                           uint8 _m,
                           uint8 _d)
                           private pure
                           returns (strings.slice[]) {

     strings.slice[] memory sYMD = new strings.slice[](3);

     sYMD[0] = StringUtils.uintToBytes(uint256(_y)).toSliceB32();
     sYMD[1] = StringUtils.uintToBytes(uint256(_m)).toSliceB32();
     sYMD[2] = StringUtils.uintToBytes(uint256(_d)).toSliceB32();

     return sYMD;
   }

   // functions to get hours and minutes from timestamp
   function getHourOrMinute(uint256 _secondsRemaining,
                            uint256 _divisor)
                            private pure
                            returns (uint256 secondsRemaining,
                                     uint8 hourOrMinute) {

     uint256 res;

     secondsRemaining = _secondsRemaining;

     res = secondsRemaining / _divisor;
     secondsRemaining -= res * _divisor;
     hourOrMinute = uint8(res);
   }

   function getHour(uint256 _secondsRemaining) private pure returns (uint256 secondsRemaining, uint8 hour) {
     return getHourOrMinute(_secondsRemaining, SECONDS_IN_HOUR);
   }

   function getMinute(uint256 _secondsRemaining) private pure returns (uint256 secondsRemaining, uint8 minute) {
     return getHourOrMinute(_secondsRemaining, SECONDS_IN_MINUTE);
   }

   /**
    @dev Convert timestamp to YMD (year, month, day)
    @param _dt Date as timestamp integer
    @return year Returns year as `uint16`
    @return month Returns month as `uint8`
    @return day Returns day as `uint8`
   */
   function convertTimestampToYMD(uint256 _dt)
                                  internal pure
                                  returns (uint16 year,
                                           uint8 month,
                                           uint8 day) {

     uint256 secondsRemaining = _dt;

    (secondsRemaining, year) = getYear(secondsRemaining);
    (secondsRemaining, month) = getMonth(secondsRemaining, year);
    (secondsRemaining, day) = getDay(secondsRemaining);
   }

   /**
    @dev Convert timestamp to YMDHMS (year, month, day, hour, minute, second)
    @param _dt Date as timestamp integer
    @return year Returns year as `uint16`
    @return month Returns month as `uint8`
    @return day Returns day as `uint8`
    @return hour Returns hour as `uint8`
    @return minute Returns minute as `uint8`
    @return second Returns second as `uint8`
   */
   function convertTimestampToYMDHMS(uint256 _dt)
                                     internal pure
                                     returns (uint16 year,
                                              uint8 month,
                                              uint8 day,
                                              uint8 hour,
                                              uint8 minute,
                                              uint8 second) {

     uint256 secondsRemaining = _dt;

    (secondsRemaining, year) = getYear(secondsRemaining);
    (secondsRemaining, month) = getMonth(secondsRemaining, year);
    (secondsRemaining, day) = getDay(secondsRemaining);
    (secondsRemaining, hour) = getHour(secondsRemaining);
    (secondsRemaining, minute) = getMinute(secondsRemaining);
    second = uint8(secondsRemaining);
   }

   /**
    @dev Convert timestamp to date string
    @param _dt Date as timestamp integer
    @return Returns date as ISO date string ("yyyy-mm-dd")
   */
   function convertTimestampToDateString(uint256 _dt) internal pure returns (string) {

     uint16 year;
     uint8 month;
     uint8 day;

    (year, month, day) = convertTimestampToYMD(_dt);
    return convertYMDtoDateString(year, month, day);
   }

   /**
    @dev Convert timestamp to date and time string
    @param _dt Date as timestamp integer
    @return Returns date as date and time string ("yyyy-mm-dd hh:mm:ss")
   */
   function convertTimestampToDateTimeString(uint256 _dt) internal pure returns (string) {

     uint16 year;
     uint8 month;
     uint8 day;
     uint8 hour;
     uint8 minute;
     uint8 second;

    (year, month, day, hour, minute, second) = convertTimestampToYMDHMS(_dt);
    return convertYMDHMStoDateTimeString(year, month, day, hour, minute, second);
   }

   /**
    @dev Convert date string to timestamp
    @param _dt Date as ISO date string ("yyyy-mm-dd")
    @return Returns timestamp as `uint256`
   */
   function convertDateStringToTimestamp(string _dt) internal pure returns (uint256) {

     require(isISOformat(_dt));

     uint16 year;
     uint8 month;
     uint8 day;

     (year, month, day) = convertDateStringToYMD(_dt);
     return convertYMDtoTimestamp(year, month, day);
   }

   /**
    @dev Convert date and time string to timestamp
    @param _dt Date as date and time string ("yyyy-mm-dd hh:mm:ss")
    @return Returns timestamp as `uint256`
   */
   function convertDateTimeStringToTimestamp(string _dt) internal pure returns (uint256) {

     require(isISOtimeFormat(_dt));

     uint16 year;
     uint8 month;
     uint8 day;
     uint8 hour;
     uint8 minute;
     uint8 second;

     (year, month, day, hour, minute, second) = convertDateTimeStringToYMDHMS(_dt);
     return convertYMDHMStoTimestamp(year, month, day, hour, minute, second);
   }

   /**
    @dev Split date string (ISO format) into year, month, day integers
    @param _dt Date as ISO date string ("yyyy-mm-dd")
    @return year Returns year as `uint16`
    @return month Returns month as `uint8`
    @return day Returns day as `uint8`
   */
   function convertDateStringToYMD(string _dt)
                                   internal pure
                                   returns (uint16 year,
                                            uint8 month,
                                            uint8 day) {

     require(isISOformat(_dt));

     strings.slice[3] memory sArr = splitISOslice(_dt);
     strings.slice memory sYear = sArr[0];
     strings.slice memory sMonth = sArr[1];
     strings.slice memory sDay = sArr[2];

     year = convertSliceToUint16(sYear);
     month = convertSliceToUint8(sMonth);
     day = convertSliceToUint8(sDay);
   }

   /**
    @dev Split date and time string into year, month, day, hour, minute, second integers
    @param _dt Date as date and time string ("yyyy-mm-dd hh:mm:ss")
    @return year Returns year as `uint16`
    @return month Returns month as `uint8`
    @return day Returns day as `uint8`
    @return hour Returns hour as `uint8`
    @return minute Returns minute as `uint8`
    @return second Returns second as `uint8`
   */
   function convertDateTimeStringToYMDHMS(string _dt)
                                          internal pure
                                          returns (uint16 year,
                                                   uint8 month,
                                                   uint8 day,
                                                   uint8 hour,
                                                   uint8 minute,
                                                   uint8 second) {

     require(isISOtimeFormat(_dt));

     strings.slice memory sISOdateTime = _dt.toSlice();
     strings.slice memory sISOdate;
     strings.slice memory sISOtime;

     sISOdate = sISOdateTime.split(" ".toSlice());
     sISOtime = sISOdateTime;

     (year, month, day) = convertDateStringToYMD(sISOdate.toString());
     (hour, minute, second) = splitTimeInt(sISOtime.toString());
   }

   /**
    @dev Convert YMD (year, month, day) to date string
    @param _year Year as integer
    @param _month Month as integer
    @param _day Day as integer
    @return Returns date as ISO string ("yyyy-mm-dd")
   */
   function convertYMDtoDateString(uint16 _year,
                                   uint8 _month,
                                   uint8 _day)
                                   internal pure
                                   returns (string) {

     require(isValidYMD(_year, _month, _day));

     strings.slice memory sHyphen = "-".toSlice();
     strings.slice memory sZero = "0".toSlice();
     strings.slice[] memory sYMD = YMDuintToBytes(_year, _month, _day);

     for (uint8 i = 1; i < 3; i++) {

       if (sYMD[i].len() == 1) {
         sYMD[i] = sZero.concat(sYMD[i]).toSlice();
       }
     }

     return sHyphen.join(sYMD);
   }

   /**
    @dev Convert YMDHMS (year, month, day, hour, minute, second) to date and time string
    @param _year Year as integer
    @param _month Month as integer
    @param _day Day as integer
    @param _day Hour as integer
    @param _day Minute as integer
    @param _day Second as integer
    @return Returns date and time as string ("yyyy-mm-dd hh:mm:ss")
   */
   function convertYMDHMStoDateTimeString(uint16 _year,
                                          uint8 _month,
                                          uint8 _day,
                                          uint8 _hour,
                                          uint8 _minute,
                                          uint8 _second)
                                          internal pure
                                          returns (string) {

     require(isValidYMDHMS(_year, _month, _day, _hour, _minute, _second));

     strings.slice[] memory sYMD = YMDuintToBytes(_year, _month, _day);
     strings.slice[] memory sHMS = YMDuintToBytes(_hour, _minute, _second);
     strings.slice[] memory sYMDHMS = new strings.slice[](2);

     for (uint8 i = 0; i < 3; i++) {

       if (sYMD[i].len() == 1) {
         sYMD[i] = "0".toSlice().concat(sYMD[i]).toSlice();
       }

       if (sHMS[i].len() == 1) {
         sHMS[i] = "0".toSlice().concat(sHMS[i]).toSlice();
       }
     }

     sYMDHMS[0] = "-".toSlice().join(sYMD).toSlice();
     sYMDHMS[1] = ":".toSlice().join(sHMS).toSlice();

     return " ".toSlice().join(sYMDHMS);
   }

   /**
    @dev Convert YMD (year, month, day) to timestamp
    @param _year Year as integer
    @param _month Month as integer
    @param _day Day as integer
    @return Returns timestamp as `uint256`
   */
   function convertYMDtoTimestamp(uint16 _year,
                                  uint8 _month,
                                  uint8 _day)
                                  internal pure
                                  returns (uint256) {

     require(isValidYMD(_year, _month, _day));

     uint256 ts = 0;

     ts = addYearSeconds(ts, _year);
     ts += addMonthSeconds(_year, _month);
     ts += (_day - 1) * SECONDS_IN_DAY;

     return ts;
   }

   /**
    @dev Convert YMDHMS (year, month, day, hour, minute, second) to timestamp
    @param _year Year as integer
    @param _month Month as integer
    @param _day Day as integer
    @param _hour Hour as integer
    @param _minute Minute as integer
    @param _second Second as integer
    @return Returns timestamp as `uint256`
   */
   function convertYMDHMStoTimestamp(uint16 _year,
                                     uint8 _month,
                                     uint8 _day,
                                     uint8 _hour,
                                     uint8 _minute,
                                     uint8 _second)
                                     internal pure
                                     returns (uint256) {

     require(isValidYMDHMS(_year, _month, _day, _hour, _minute, _second));

     uint256 ts = 0;

     ts = addYearSeconds(ts, _year);
     ts += addMonthSeconds(_year, _month);
     ts += (_day - 1) * SECONDS_IN_DAY;
     ts += _hour * SECONDS_IN_HOUR;
     ts += _minute * SECONDS_IN_MINUTE;
     ts += uint256(_second);

     return ts;
   }
}
