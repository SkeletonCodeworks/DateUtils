* [DateUtils](#dateutils)
  * [isValidYMD](#function-isvalidymd)
  * [isValidYMDHMS](#function-isvalidymdhms)
  * [splitTimeInt](#function-splittimeint)
  * [isISOformat](#function-isisoformat)
  * [isISOtimeFormat](#function-isisotimeformat)
  * [isLeapYear](#function-isleapyear)
  * [getWeekday](#function-getweekday)
  * [convertTimestampToYMD](#function-converttimestamptoymd)
  * [convertTimestampToYMDHMS](#function-converttimestamptoymdhms)
  * [convertTimestampToDateString](#function-converttimestamptodatestring)
  * [convertTimestampToDateTimeString](#function-converttimestamptodatetimestring)
  * [convertDateStringToTimestamp](#function-convertdatestringtotimestamp)
  * [convertDateTimeStringToTimestamp](#function-convertdatetimestringtotimestamp)
  * [convertDateStringToYMD](#function-convertdatestringtoymd)
  * [convertDateTimeStringToYMDHMS](#function-convertdatetimestringtoymdhms)
  * [convertYMDtoDateString](#function-convertymdtodatestring)
  * [convertYMDHMStoDateTimeString](#function-convertymdhmstodatetimestring)
  * [convertYMDtoTimestamp](#function-convertymdtotimestamp)
  * [convertYMDHMStoTimestamp](#function-convertymdhmstotimestamp)

* [Date](#date)
  * [public-members](#public-members)
  * [constructor](#constructor)
  * [setDateFromString](#function-setdatefromstring)
  * [setDateTimeFromString](#function-setdatetimefromstring)
  * [setDateFromTimestamp](#function-setdatefromtimestamp)
  * [setDateTimeFromTimestamp](#function-setdatetimefromtimestamp)
  * [setDateFromYMD](#function-setdatefromymd)
  * [setDateTimeFromYMDHMS](#function-setdatetimefromymdhms)
  * [getDateString](#function-getdatestring)
  * [getDateTimeString](#function-getdatetimestring)
  * [getTimestamp](#function-gettimestamp)
  * [terminate](#function-terminate)

# DateUtils

> Date utility library for Solidity contracts

Skeleton Codeworks, LLC

<skeleton.codeworks@gmail.com>


>      This library primarily provides utilities to convert between various
>      date and time formats.  The supported formats are: 1) Unix timestamps,
>      2) strings in yyyy-mm-dd format (also known as ISO), and
>      3) YMD format (year, month, day, as integers).
> 
>      Additionally, support is provided for the date and time formats
>      analogous to the date formats above: 1) Unix timestamps (identical to
>      the format above), 2) strings in yyyy-mm-dd hh:mm:ss format, and
>      3) YMDHMS format (year, month, day, hour, minute, second, as integers).
>      Hours, minutes, and seconds are in 24-hour clock format (i.e., hour
>      from 0 - 23, minute from 0 - 59, and second from 0 - 59).
> 
>      Convenience functions for validation, splitting date strings, and
>      calculating the day of the week are also provided.
> 
>      Note that this library does not use "yyyy-mm-ddThh:mm:ssZ" as valid
>      date and time format, but rather "yyyy-mm-dd hh:mm:ss".


### *function* isValidYMD

DateUtils.isValidYMD(_y, _m, _d) `pure`

> Check valid YMD (year, month, day)

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _y | Year as integer; must be >= 1970 and <= 9999 |
| `uint8` | _m | Month as integer; must be >= 1 and <= 12 |
| `uint8` | _d | Day as integer; must be >= 1 and <= 31 |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `bool` |  | Returns `true` if all inputs are valid, `false` otherwise |


### *function* isValidYMDHMS

DateUtils.isValidYMDHMS(_y, _m, _d, _h, _min, _s) `pure`

> Check valid YMDHMS (year, month, day, hour, minute, second)

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _y | Year as integer; must be >= 1970 and <= 9999 |
| `uint8` | _m | Month as integer; must be >= 1 and <= 12 |
| `uint8` | _d | Day as integer; must be >= 1 and <= 31 |
| `uint8` | _h | Hour as integer; must be >= 0 and <= 23 |
| `uint8` | _min | Minute as integer; must be >= 0 and <= 59 |
| `uint8` | _s | Second as integer; must be >= 0 and <= 59 |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `bool` |  | Returns `true` if all inputs are valid, `false` otherwise |


### *function* splitTimeInt

DateUtils.splitTimeInt(_time) `pure`

> Split time string (ISO format) into hour, minute, second integers

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _time | Time as hh:mm:ss string |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint8` | hour | Returns hour as `uint8` |
| `uint8` | minute | Returns minute as `uint8` |
| `uint8` | second | Returns second as `uint8` |


### *function* isISOformat

DateUtils.isISOformat(_dt) `pure`

> Check valid ISO date string format ("yyyy-mm-dd")

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as string |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `bool` |  | Returns `true` if `_dt` is valid ISO format, `false` otherwise |


### *function* isISOtimeFormat

DateUtils.isISOtimeFormat(_dt) `pure`

> Check valid date and time string format ("yyyy-mm-dd hh:mm:ss")

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date and time as string |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `bool` |  | Returns `true` if `_dt` is valid yyyy-mm-dd hh:mm:ss format, `false` otherwise |


### *function* isLeapYear

DateUtils.isLeapYear(_year) `pure`

> Check if year is a leap year

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _year | Year as integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `bool` |  | Returns `true` if `_year` is a leap year, `false` otherwise |


### *function* getWeekday

DateUtils.getWeekDay(_timestamp) `pure`

> Get day of the week of a timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _timestamp | Timestamp as integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint8` |  | Returns day of the week as `uint8` (0 is Sunday, and 6 is Saturday) |


### *function* convertTimestampToYMD

DateUtils.convertTimestampToYMD(_dt) `pure`

> Convert timestamp to YMD (year, month, day)

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _dt | Date as timestamp integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Returns year as `uint16` |
| `uint8` | month | Returns month as `uint8` |
| `uint8` | day | Returns day as `uint8` |


### *function* convertTimestampToYMDHMS

DateUtils.convertTimestampToYMDHMS(_dt) `pure`

> Convert timestamp to YMDHMS (year, month, day, hour, minute, second)

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _dt | Date as timestamp integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Returns year as `uint16` |
| `uint8` | month | Returns month as `uint8` |
| `uint8` | day | Returns day as `uint8` |
| `uint8` | hour | Returns hour as `uint8` |
| `uint8` | minute | Returns minute as `uint8` |
| `uint8` | second | Returns second as `uint8` |


### *function* convertTimestampToDateString

DateUtils.convertTimestampToDateString(_dt) `pure`

> Convert timestamp to date string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _dt | Date as timestamp integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date as ISO date string ("yyyy-mm-dd") |


### *function* convertTimestampToDateTimeString

DateUtils.convertTimestampToDateTimeString(_dt) `pure`

> Convert timestamp to date and time string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _dt | Date as timestamp integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date as date and time string ("yyyy-mm-dd hh:mm:ss") |


### *function* convertDateStringToTimestamp

DateUtils.convertDateStringToTimestamp(_dt) `pure`

> Convert date string to timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as ISO date string ("yyyy-mm-dd") |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` |  | Returns timestamp as `uint256` |


### *function* convertDateTimeStringToTimestamp

DateUtils.convertDateTimeStringToTimestamp(_dt) `pure`

> Convert date and time string to timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as date and time string ("yyyy-mm-dd hh:mm:ss") |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` |  | Returns timestamp as `uint256` |


### *function* convertDateStringToYMD

DateUtils.convertDateStringToYMD(_dt) `pure`

> Split date string (ISO format) into year, month, day integers

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as ISO date string ("yyyy-mm-dd") |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Returns year as `uint16` |
| `uint8` | month | Returns month as `uint8` |
| `uint8` | day | Returns day as `uint8` |


### *function* convertDateTimeStringToYMDHMS

DateUtils.convertDateTimeStringToYMDHMS(_dt) `pure`

> Split date and time string into year, month, day, hour, minute, second integers

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as date and time string ("yyyy-mm-dd hh:mm:ss") |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Returns year as `uint16` |
| `uint8` | month | Returns month as `uint8` |
| `uint8` | day | Returns day as `uint8` |
| `uint8` | hour | Returns hour as `uint8` |
| `uint8` | minute | Returns minute as `uint8` |
| `uint8` | second | Returns second as `uint8` |


### *function* convertYMDtoDateString

DateUtils.convertYMDtoDateString(_year, _month, _day) `pure`

> Convert YMD (year, month, day) to date string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Year as integer |
| `uint8` | month | Month as integer |
| `uint8` | day | Day as integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date as ISO string ("yyyy-mm-dd") |


### *function* convertYMDHMStoDateTimeString

DateUtils.convertYMDHMStoDateTimeString(_year, _month, _day, _hour, _minute, _second) `pure`

> Convert YMDHMS (year, month, day, hour, minute, second) to date and time string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Year as integer |
| `uint8` | month | Month as integer |
| `uint8` | day | Day as integer |
| `uint8` | hour | Hour as integer |
| `uint8` | minute | Minute as integer |
| `uint8` | second | Second as integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date and time as string ("yyyy-mm-dd hh:mm:ss") |


### *function* convertYMDtoTimestamp

DateUtils.convertYMDtoTimestamp(_year, _month, _day) `pure`

> Convert YMD (year, month, day) to timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Year as integer |
| `uint8` | month | Month as integer |
| `uint8` | day | Day as integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` |  | Returns timestamp as `uint256` |


### *function* convertYMDHMStoTimestamp

DateUtils.convertYMDHMStoTimestamp(_year, _month, _day, _hour, _minute, _second) `pure`

> Convert YMDHMS (year, month, day, hour, minute, second) to timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Year as integer |
| `uint8` | month | Month as integer |
| `uint8` | day | Day as integer |
| `uint8` | hour | Hour as integer |
| `uint8` | minute | Minute as integer |
| `uint8` | second | Second as integer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` |  | Returns timestamp as `uint256` |


# Date

> Date object Solidity contract

Skeleton Codeworks, LLC

<skeleton.codeworks@gmail.com>


>      This contract provides multi-purpose storage for date objects in
>      six different formats, stored as public members.  The formats are:
>      1) "yyyy-mm-dd" date string format (also known as ISO),
>      2) "yyyy-mm-dd hh:mm:ss" date and time string format,
>      3) Unix timestamp format,
>      4) Dt struct format, a struct with year, month, day, and
>         weekday attributes,
>      5) DtTime struct format, a struct with year, month, day, hour,
>         minute, second and weekday attributes,
>      6) year, month, day, hour, minute, second, and weekday members on
>         the contract itself.
> 
>      Whenever the contract is set using one of the several available
>      set functions, including at initialization, then all six of the above
>      formats are set to the same date and time, so that all members of the
>      contract will always be in agreement.  The contract can be reset
>      with a new date any number times.


### *public-members*

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Year (>= 1970, <= 9999) |
| `uint8` | month | Month (1 - 12) |
| `uint8` | day | Day (1 - 31) |
| `uint8` | hour | Hour (0 - 23) |
| `uint8` | minute | Minute (0 - 59) |
| `uint8` | second | Second (0 - 59) |
| `string` | weekday | Day of the week (e.g., "Monday") |
| `string` | isoDate | Date in ISO format ("yyyy-mm-dd") |
| `string` | isoDateTime | Date and time in quasi-ISO format ("yyyy-mm-dd hh:mm:ss") |
| `uint256` | timestampDate | Date in Unix time format |
| `Dt` | dt | Date as a `Dt` struct (object with members: `uint16` year, `uint8` month, `uint8` day, and `string` weekday) |
| `DtTime` | dtTime | Date as a `DtTime` struct (object with members: `uint16` year, `uint8` month, `uint8` day, `uint8` hour, `uint8` minute, `uint8` second, and `string` weekday) |
| `address` | owner | Owner address |


### *constructor*

Date(_year, _month, _day)

> Create Date object.  Must be initialized with year, month, day only - all time members are set to 0.

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _year | Year as integer |
| `uint8` | _month | Month as integer |
| `uint8` | _day | Day as integer |


### *function* setDateFromString

Date.setDateFromString(_dt) `nonpayable`

> Set date from date string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as ISO date string ("yyyy-mm-dd") |


### *function* setDateTimeFromString

Date.setDateTimeFromString(_dt) `nonpayable`

> Set date and time from date and time string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as date and time string ("yyyy-mm-dd hh:mm:ss") |


### *function* setDateFromTimestamp

Date.setDateFromTimestamp(_timestamp) `nonpayable`

> Set date from timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _timestamp | Date as timestamp integer |


### *function* setDateTimeFromTimestamp

Date.setDateTimeFromTimestamp(_timestamp) `nonpayable`

> Set date and time from timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _timestamp | Date as timestamp integer |


### *function* setDateFromYMD

Date.setDateFromYMD(_year, _month, _day) `nonpayable`

> Set date from year, month, day

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _year | Year as integer |
| `uint8` | _month | Month as integer |
| `uint8` | _day | Day as integer |


### *function* setDateTimeFromYMDHMS

Date.setDateTimeFromYMDHMS(_year, _month, _day, _hour, _minute, _second) `nonpayable`

> Set date and time from year, month, day, hour, minute, second

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _year | Year as integer |
| `uint8` | _month | Month as integer |
| `uint8` | _day | Day as integer |
| `uint8` | _hour | Hour as integer |
| `uint8` | _minute | Minute as integer |
| `uint8` | _second | Second as integer |


### *function* getDateString

Date.getDateString() `view`

> Get date string



Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date string as "yyyy-mm-dd" |


### *function* getDateTimeString

Date.getDateTimeString() `view`

> Get date and time string



Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date and time string as "yyyy-mm-dd hh:mm:ss" |


### *function* getTimestamp

Date.getTimestamp() `view`

> Get date as timestamp



Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` |  | Returns timestamp as `uint256` |


### *function* terminate

Date.terminate() `nonpayable`

> Terminate contract - must be owner

