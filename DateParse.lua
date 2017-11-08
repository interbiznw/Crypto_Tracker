function Initialize()

   measureSiteUpdated = SKIN:GetMeasure('MeasureSiteUpdated')

end

function Update()

end

function DateParse()

   local feedDate = measureSiteUpdated:GetStringValue()

   local timeNowLocal = os.time(os.date('*t'))
   local timeNowGMT = os.time(os.date('!*t'))

   local timeZoneOffset = (timeNowLocal) - timeNowGMT
   local dstOffset = os.date('*t')['isdst'] and 3600 or 0
   local convertToWindows = 11644473600

   local itemTimeGMT = itemTimeGMTStamp(feedDate)
   local itemTimeDiff = timeNowGMT - itemTimeGMT
   local itemLocalTime = (timeNowLocal + dstOffset) - itemTimeDiff

   SKIN:Bang('!SetOption', 'MeasureGMTTime', 'TimeStamp', itemTimeGMT + timeZoneOffset + convertToWindows)
   SKIN:Bang('!SetOption', 'MeasureLocalTime', 'TimeStamp', itemLocalTime + timeZoneOffset + convertToWindows)
   SKIN:Bang('!ShowMeter', 'MeterOutput')
   SKIN:Bang('!SetOption', 'MyMeter', 'Text', 'Hello, world!')

end

function itemTimeGMTStamp(itemDate)

   -- feed date format: 2014-06-10T11:44:07Z
   local year, month, day, hour, min, sec, zone =
   string.match(itemDate, "(%d%d%d%d)-(%d%d)-(%d%d)T(%d%d):(%d%d):(%d%d)(.-)")

   return os.time({year=year, month=month, day=day, hour=hour, min=min, sec=sec, isdst=false})

end
