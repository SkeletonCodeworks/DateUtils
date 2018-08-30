* [Date](#date)
  * [terminate](#function-terminate)
  * [setDateFromYMD](#function-setdatefromymd)
  * [getTimestamp](#function-gettimestamp)
  * [hour](#function-hour)
  * [isoDate](#function-isodate)
  * [setDateTimeFromYMDHMS](#function-setdatetimefromymdhms)
  * [timestampDate](#function-timestampdate)
  * [isoDateTime](#function-isodatetime)
  * [setDateTimeFromString](#function-setdatetimefromstring)
  * [dt](#function-dt)
  * [second](#function-second)
  * [month](#function-month)
  * [getDateString](#function-getdatestring)
  * [day](#function-day)
  * [owner](#function-owner)
  * [setDateFromString](#function-setdatefromstring)
  * [setDateTimeFromTimestamp](#function-setdatetimefromtimestamp)
  * [setDateFromTimestamp](#function-setdatefromtimestamp)
  * [dtTime](#function-dttime)
  * [getDateTimeString](#function-getdatetimestring)
  * [weekday](#function-weekday)
  * [minute](#function-minute)
  * [year](#function-year)
* [DateUtils](#dateutils)
* [StringUtils](#stringutils)
  * [bytesToUInt](#function-bytestouint)
  * [uintToBytes](#function-uinttobytes)
  * [stringToBytes32](#function-stringtobytes32)
* [strings](#strings)
  * [log_bytemask](#event-log_bytemask)

# Date

Skeleton Codeworks, LLC <skeleton.codeworks@gmail.com>

## *function* terminate

Date.terminate() `nonpayable` `0c08bf88`

> Terminate contract - must be owner




## *function* setDateFromYMD

Date.setDateFromYMD(_year, _month, _day) `nonpayable` `131dab3d`

> Set date from year, month, day

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint16* | _year | Year as integer |
| *uint8* | _month | Month as integer |
| *uint8* | _day | Day as integer |


## *function* getTimestamp

Date.getTimestamp() `view` `188ec356`

> Get date as timestamp



Outputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* |  | Returns timestamp as `uint256` |

## *function* hour

Date.hour() `view` `23e5f1c5`





## *function* isoDate

Date.isoDate() `view` `25e54ae7`





## *function* setDateTimeFromYMDHMS

Date.setDateTimeFromYMDHMS(_year, _month, _day, _hour, _minute, _second) `nonpayable` `305069c2`

> Set date and time from year, month, day, hour, minute, second

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint16* | _year | Year as integer |
| *uint8* | _month | Month as integer |
| *uint8* | _day | Day as integer |
| *uint8* | _hour | Hour as integer |
| *uint8* | _minute | Minute as integer |
| *uint8* | _second | Second as integer |


## *function* timestampDate

Date.timestampDate() `view` `38846850`





## *function* isoDateTime

Date.isoDateTime() `view` `3c30b781`





## *function* setDateTimeFromString

Date.setDateTimeFromString(_dt) `nonpayable` `3fada22b`

> Set date and time from date and time string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *string* | _dt | Date as date and time string (yyyy-mm-dd hh:mm:ss) |


## *function* dt

Date.dt() `view` `3fdb8cbd`





## *function* second

Date.second() `view` `5a8ac02d`





## *function* month

Date.month() `view` `702921f5`





## *function* getDateString

Date.getDateString() `view` `793a8343`

> Get date string



Outputs

| **type** | **name** | **description** |
|-|-|-|
| *string* |  | Returns date string as "yyyy-mm-dd" |

## *function* day

Date.day() `view` `7b76ac91`





## *function* owner

Date.owner() `view` `8da5cb5b`





## *function* setDateFromString

Date.setDateFromString(_dt) `nonpayable` `a2c00e4f`

> Set date from date string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *string* | _dt | Date as ISO date string (yyyy-mm-dd) |


## *function* setDateTimeFromTimestamp

Date.setDateTimeFromTimestamp(_timestamp) `nonpayable` `c1bec381`

> Set date and time from timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | _timestamp | Date as timestamp integer |


## *function* setDateFromTimestamp

Date.setDateFromTimestamp(_timestamp) `nonpayable` `c85c2d38`

> Set date from timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | _timestamp | Date as timestamp integer |


## *function* dtTime

Date.dtTime() `view` `ce449b7b`





## *function* getDateTimeString

Date.getDateTimeString() `view` `d048af9e`

> Get date and time string



Outputs

| **type** | **name** | **description** |
|-|-|-|
| *string* |  | Returns date and time string as "yyyy-mm-dd hh:mm:ss" |

## *function* weekday

Date.weekday() `view` `dffe3785`





## *function* minute

Date.minute() `view` `e89b7222`





## *function* year

Date.year() `view` `f3269716`






---
# DateUtils


---
# StringUtils

Piper Merriam - <pipermerriam@gmail.com>

## *function* bytesToUInt

StringUtils.bytesToUInt(v) `pure` `81a33a6f`

> Converts a numeric string to it's unsigned integer representation.

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | v | The string to be converted. |


## *function* uintToBytes

StringUtils.uintToBytes(v) `pure` `94e8767d`

> Converts an unsigned integert to its string representation.

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | v | The number to be converted. |


## *function* stringToBytes32

StringUtils.stringToBytes32(_src) `pure` `cfb51928`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *string* | _src | undefined |


---
# strings

## *event* log_bytemask

strings.log_bytemask(mask) `f566b46a`

Arguments

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | mask | not indexed |


---