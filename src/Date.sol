pragma solidity ^0.4.24;

import "./strings.sol";
import "./DateUtils.sol";

/**
 @title Date object Solidity contract
 @author Skeleton Codeworks, LLC <skeleton.codeworks@gmail.com>

 @dev This contract provides multi-purpose storage for date objects in
      six different formats, stored as public members.  The formats are:
      1) "yyyy-mm-dd" date string format (also known as ISO),
      2) "yyyy-mm-dd hh:mm:ss" date and time string format,
      3) Unix timestamp format,
      4) Dt struct format, a struct with year, month, day, and
         weekday attributes,
      5) DtTime struct format, a struct with year, month, day, hour,
         minute, second and weekday attributes,
      6) year, month, day, hour, minute, second, and weekday members on
         the contract itself.

      Whenever the contract is set using one of the several available
      set functions, including at initialization, then all six of the above
      formats are set to the same date and time, so that all members of the
      contract will always be in agreement.  The contract can be reset
      with a new date any number times.
*/

contract Date {

   using strings for *;
   using DateUtils for *;

   struct Dt {
     uint16 year;
     uint8 month;
     uint8 day;
     string weekday;
   }

   struct DtTime {
     uint16 year;
     uint8 month;
     uint8 day;
     uint8 hour;
     uint8 minute;
     uint8 second;
     string weekday;
   }

   string[7] private weekdayMap = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
   address public owner;
   Dt public dt;
   DtTime public dtTime;
   uint256 public timestampDate;
   string public isoDate; // "yyyy-mm-dd" format
   string public isoDateTime; // "yyyymm-dd hh:mm:ss" format
   uint16 public year;
   uint8 public month;
   uint8 public day;
   uint8 public hour;
   uint8 public minute;
   uint8 public second;
   string public weekday;

   modifier restricted() {
     if (msg.sender == owner) _;
   }

   // must be initialized with year, month, day - all time members are set to 0
   constructor(uint16 _year,
               uint8 _month,
               uint8 _day)
               public {

     require(DateUtils.isValidYMD(_year, _month, _day));

     owner = msg.sender;

     year = _year;
     month = _month;
     day = _day;
     hour = 0;
     minute = 0;
     second = 0;

     isoDate = DateUtils.convertYMDtoDateString(_year, _month, _day);
     isoDateTime = DateUtils.convertYMDHMStoDateTimeString(_year, _month, _day, 0, 0, 0);

     timestampDate = DateUtils.convertYMDtoTimestamp(_year, _month, _day);
     weekday = weekdayMap[DateUtils.getWeekday(timestampDate)];

     dt.year = _year;
     dt.month = _month;
     dt.day = _day;
     dt.weekday = weekday;

     dtTime.year = _year;
     dtTime.month = _month;
     dtTime.day = _day;
     dtTime.hour = 0;
     dtTime.minute = 0;
     dtTime.second = 0;
     dtTime.weekday = weekday;
   }

   // function to set YMDHMS members, dt struct, and dtTime struct
   // with ISO date string
   function setYMDwithISO(string _isoDate) private {

     (year, month, day) = DateUtils.convertDateStringToYMD(_isoDate);
     hour = 0;
     minute = 0;
     second = 0;

     dt.year = year;
     dt.month = month;
     dt.day = day;

     dtTime.year = year;
     dtTime.month = month;
     dtTime.day = day;
     dtTime.hour = 0;
     dtTime.minute = 0;
     dtTime.second = 0;
   }

   // function to set YMDHMS members, dt struct, and dtTime struct
   // with date and time string
   function setYMDHMSwithISOtime(string _isoDateTime) private {

     strings.slice memory sISOdateTime = _isoDateTime.toSlice();
     strings.slice memory sISOdate;
     strings.slice memory sISOtime;

     sISOdate = sISOdateTime.split(" ".toSlice());
     sISOtime = sISOdateTime;

     (year, month, day) = DateUtils.convertDateStringToYMD(sISOdate.toString());
     (hour, minute, second) = DateUtils.splitTimeInt(sISOtime.toString());

     dt.year = year;
     dt.month = month;
     dt.day = day;

     dtTime.year = year;
     dtTime.month = month;
     dtTime.day = day;
     dtTime.hour = hour;
     dtTime.minute = minute;
     dtTime.second = second;
   }

   // function to set weekday from timestamp
   function setWeekday(uint256 _timestamp) private {

    weekday = weekdayMap[DateUtils.getWeekday(_timestamp)];
    dt.weekday = weekday;
    dtTime.weekday = weekday;
   }

   /**
    @dev Set date from date string
    @param _dt Date as ISO date string ("yyyy-mm-dd")
   */
   function setDateFromString(string _dt) public {

     require(DateUtils.isISOformat(_dt));

     isoDate = _dt;
     isoDateTime = _dt.toSlice().concat(" 00:00:00".toSlice());
     setYMDwithISO(isoDate);
     timestampDate = DateUtils.convertYMDtoTimestamp(year, month, day);
     setWeekday(timestampDate);
   }

   /**
    @dev Set date and time from date and time string
    @param _dt Date as date and time string ("yyyy-mm-dd hh:mm:ss")
   */
   function setDateTimeFromString(string _dt) public {

     require(DateUtils.isISOtimeFormat(_dt));

     isoDate = _dt.toSlice().split(" ".toSlice()).toString();
     isoDateTime = _dt;
     setYMDHMSwithISOtime(isoDateTime);
     timestampDate = DateUtils.convertYMDHMStoTimestamp(year, month, day, hour, minute, second);
     setWeekday(timestampDate);
   }

   /**
    @dev Set date from timestamp
    @param _timestamp Date as timestamp integer
   */
   function setDateFromTimestamp(uint256 _timestamp) public {

     isoDate = DateUtils.convertTimestampToDateString(_timestamp);
     isoDateTime = isoDate.toSlice().concat(" 00:00:00".toSlice());
     setYMDwithISO(isoDate);
     timestampDate = _timestamp;
     setWeekday(_timestamp);
   }

   /**
    @dev Set date and time from timestamp
    @param _timestamp Date as timestamp integer
   */
   function setDateTimeFromTimestamp(uint256 _timestamp) public {

     isoDateTime = DateUtils.convertTimestampToDateTimeString(_timestamp);
     isoDate = isoDateTime.toSlice().split(" ".toSlice()).toString();
     setYMDHMSwithISOtime(isoDateTime);
     timestampDate = _timestamp;
     setWeekday(_timestamp);
   }

   /**
    @dev Set date from year, month, day
    @param _year Year as integer
    @param _month Month as integer
    @param _day Day as integer
   */
   function setDateFromYMD(uint16 _year,
                           uint8 _month,
                           uint8 _day)
                           public {

    isoDate = DateUtils.convertYMDtoDateString(_year, _month, _day);
    isoDateTime = isoDate.toSlice().concat(" 00:00:00".toSlice());
    setYMDwithISO(isoDate);
    timestampDate = DateUtils.convertYMDtoTimestamp(_year, _month, _day);
    setWeekday(timestampDate);
   }

   /**
    @dev Set date and time from year, month, day, hour, minute, second
    @param _year Year as integer
    @param _month Month as integer
    @param _day Day as integer
    @param _hour Hour as integer
    @param _minute Minute as integer
    @param _second Second as integer
   */
   function setDateTimeFromYMDHMS(uint16 _year,
                                  uint8 _month,
                                  uint8 _day,
                                  uint8 _hour,
                                  uint8 _minute,
                                  uint8 _second)
                                  public {

    isoDateTime = DateUtils.convertYMDHMStoDateTimeString(_year, _month, _day, _hour, _minute, _second);
    isoDate = isoDateTime.toSlice().split(" ".toSlice()).toString();
    setYMDHMSwithISOtime(isoDateTime);
    timestampDate = DateUtils.convertYMDHMStoTimestamp(_year, _month, _day, _hour, _minute, _second);
    setWeekday(timestampDate);
   }

   /**
    @dev Get date string
    @return {
      "": "Returns date string as \"yyyy-mm-dd\""
    }
   */
   function getDateString() public view returns (string) {
     return isoDate;
   }

   /**
    @dev Get date and time string
    @return {
      "" : "Returns date and time string as \"yyyy-mm-dd hh:mm:ss\""
    }
   */
   function getDateTimeString() public view returns (string) {
     return isoDateTime;
   }

   /**
    @dev Get date as timestamp
    @return {
      "": "Returns timestamp as `uint256`"
    }
   */
   function getTimestamp() public view returns (uint256) {
     return timestampDate;
   }

   /**
    @dev Terminate contract - must be owner
   */
   function terminate() external restricted {
     selfdestruct(msg.sender);
   }
}
