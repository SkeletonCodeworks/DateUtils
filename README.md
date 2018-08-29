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


## *function* terminate

Date.terminate() `nonpayable` `0c08bf88`





## *function* setDateFromYMD

Date.setDateFromYMD(_year, _month, _day) `nonpayable` `131dab3d`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint16* | _year | undefined |
| *uint8* | _month | undefined |
| *uint8* | _day | undefined |


## *function* getTimestamp

Date.getTimestamp() `view` `188ec356`





## *function* hour

Date.hour() `view` `23e5f1c5`





## *function* isoDate

Date.isoDate() `view` `25e54ae7`





## *function* setDateTimeFromYMDHMS

Date.setDateTimeFromYMDHMS(_year, _month, _day, _hour, _minute, _second) `nonpayable` `305069c2`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint16* | _year | undefined |
| *uint8* | _month | undefined |
| *uint8* | _day | undefined |
| *uint8* | _hour | undefined |
| *uint8* | _minute | undefined |
| *uint8* | _second | undefined |


## *function* timestampDate

Date.timestampDate() `view` `38846850`





## *function* isoDateTime

Date.isoDateTime() `view` `3c30b781`





## *function* setDateTimeFromString

Date.setDateTimeFromString(_dt) `nonpayable` `3fada22b`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *string* | _dt | undefined |


## *function* dt

Date.dt() `view` `3fdb8cbd`





## *function* second

Date.second() `view` `5a8ac02d`





## *function* month

Date.month() `view` `702921f5`





## *function* getDateString

Date.getDateString() `view` `793a8343`





## *function* day

Date.day() `view` `7b76ac91`





## *function* owner

Date.owner() `view` `8da5cb5b`





## *function* setDateFromString

Date.setDateFromString(_dt) `nonpayable` `a2c00e4f`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *string* | _dt | undefined |


## *function* setDateTimeFromTimestamp

Date.setDateTimeFromTimestamp(_timestamp) `nonpayable` `c1bec381`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | _timestamp | undefined |


## *function* setDateFromTimestamp

Date.setDateFromTimestamp(_timestamp) `nonpayable` `c85c2d38`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | _timestamp | undefined |


## *function* dtTime

Date.dtTime() `view` `ce449b7b`





## *function* getDateTimeString

Date.getDateTimeString() `view` `d048af9e`





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