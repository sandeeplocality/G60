<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="G60.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<script type="text/javascript">
        $.ajax({
            type: "POST",
            url: "Handler.ashx",
            data: { firstName: 'stack', lastName: 'overflow' },
            // DO NOT SET CONTENT TYPE to json
            // contentType: "application/json; charset=utf-8", 
            // DataType needs to stay, otherwise the response object
            // will be treated as a single string
            dataType: "json",
            success: function (response) {
                alert(response.d);
            }
        });
    </script>--%>
    <script src="Scripts/jquery-1.3.2.js" type="text/javascript"></script>
    <script src="Scripts/json2.js" type="text/javascript"></script>
    <%-- <script language="javascript" type="text/javascript">
        $(function () {
            $("#RunAjaxForm").submit(function (e) {
                alert("aa");
                e.preventDefault();
                alert("bb");
                $.ajax({
                    type: "GET",
                    url: "../Handler.ashx",
                    data: { firstName: 'stack', lastName: 'overflow' },
                    dataType: "json",
                    success: function (msg) {
                        alert(msg);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        var msg = JSON.parse(XMLHttpRequest.responseText);
                        alert(msg.Message);
                    }
                });
                alert("cc");
            });
        });       
    </script>--%>
    <script language="javascript" type="text/javascript">
        $(function () {
            // $("#RunAjaxForm").submit(function (e) {
            //            var strJson = { id: '12', name: 'adi' };

            //            function replacer(key, value) {
            //                if (typeof value === "string") {
            //                    return undefined;
            //                }
            //                return value;
            //            }

            //  var foo = { id: "Mozilla", name: "box", SerNo: "12345" };
            //var jsonString = JSON.stringify(foo, ['id', 'name', 'SerNo']);


            var abcd = {
                "SerNo": 100482,
                "IMEI": "351579050616323",
                "ICCID": "89610164556427000029",
                "ProdId": 17,
                "FW": "17.1.1.23",
                "Records": [
 {
     "SeqNo": 24866,
     "Reason": 11,
     "DateUTC": "2014-05-12 12:57:14",
     "Fields": [
 {
     "GpsUTC": "2014-05-12 09:26:39",
     "Lat": -31.9535124,
     "Long": 115.8241971,
     "Alt": 18,
     "Spd": 4,
     "SpdAcc": 2,
     "Head": 0,
     "PDOP": 28,
     "PosAcc": 12,
     "GpsStat": 3,
     "FType": 0
 },
 {
     "DIn": 0,
     "DOut": 0,
     "DevStat": 2,
     "FType": 2
 },
 {
     "AnalogueData": {
         "4": 25,
         "1": 4144,
         "2": 30,
         "5": 3,
         "3": 1467
     },
     "FType": 6
 }
     ]
 },
 {
     "SeqNo": 24867,
     "Reason": 28,
     "DateUTC": "2014-05-13 05:56:22",
     "Fields": []
 },
 {
     "SeqNo": 24868,
     "Reason": 28,
     "DateUTC": "2014-05-13 05:56:27",
     "Fields": []
 },
 {
     "SeqNo": 24869,
     "Reason": 11,
     "DateUTC": "2014-05-12 13:12:17",
     "Fields": [
 {
     "GpsUTC": "2014-05-12 09:26:39",
     "Lat": -31.9535124,
     "Long": 115.8241971,
     "Alt": 18,
     "Spd": 4,
     "SpdAcc": 2,
     "Head": 0,
     "PDOP": 28,
     "PosAcc": 12,
     "GpsStat": 3,
     "FType": 0
 },
 {
     "DIn": 0,
     "DOut": 0,
     "DevStat": 2,
     "FType": 2
 },
 {
     "AnalogueData": {
         "4": 25,
         "1": 4145,
         "2": 30,
         "5": 2,
         "3": 1504
     },
     "FType": 6
 }
     ]
 }
                ]
            }


            var abcd1 = {
                "SerNo": 100482,
                "IMEI": "351579050616323",
                "ICCID": "89610164556427000029",
                "ProdId": 17,
                "FW": "17.1.1.23"
            }






            var jsonString = JSON.stringify(abcd, ['SerNo', 'IMEI', 'ICCID', 'ProdId', 'FW', 'Records', 'SeqNo', 'Reason', 'DateUTC', 'Fields', 'GpsUTC', 'Lat', 'Long', 'Alt', 'Spd', 'SpdAcc', 'Head', 'PDOP', 'PosAcc', 'GpsStat', 'FType']);
            var jsonString = JSON.stringify(abcd1, ['SerNo', 'IMEI', 'ICCID', 'ProdId', 'FW']);
            var jsonString = "DeviceData=%7b%22SerNo%22%3a110038%2c%22IMEI%22%3a%22351579054964018%22%2c%22ICCID%22%3a%2289610188725434000030%22%2c%22ProdId%22%3a23%2c%22FW%22%3a%2223.2.1.29%22%2c%22Records%22%3a%5b%7b%22SeqNo%22%3a35705%2c%22Reason%22%3a17%2c%22DateUTC%22%3a%222015-07-10+03%3a15%3a38%22%2c%22Fields%22%3a%5b%7b%22GpsUTC%22%3a%222015-07-10+02%3a39%3a52%22%2c%22Lat%22%3a-33.7900917%2c%22Long%22%3a150.8895239%2c%22Alt%22%3a97%2c%22Spd%22%3a0%2c%22SpdAcc%22%3a4%2c%22Head%22%3a0%2c%22PDOP%22%3a20%2c%22PosAcc%22%3a18%2c%22GpsStat%22%3a3%2c%22FType%22%3a0%7d%2c%7b%22DIn%22%3a1%2c%22DOut%22%3a0%2c%22DevStat%22%3a6%2c%22FType%22%3a2%7d%2c%7b%22AnalogueData%22%3a%7b%224%22%3a18%2c%221%22%3a4203%2c%222%22%3a1248%2c%223%22%3a2131%7d%2c%22FType%22%3a6%7d%2c%7b%22DType%22%3a2%2c%22Data%22%3a%22AAAJtuE5%22%2c%22FType%22%3a3%7d%5d%7d%2c%7b%22SeqNo%22%3a35706%2c%22Reason%22%3a17%2c%22DateUTC%22%3a%222015-07-10+03%3a15%3a40%22%2c%22Fields%22%3a%5b%7b%22GpsUTC%22%3a%222015-07-10+02%3a39%3a52%22%2c%22Lat%22%3a-33.7900917%2c%22Long%22%3a150.8895239%2c%22Alt%22%3a97%2c%22Spd%22%3a0%2c%22SpdAcc%22%3a4%2c%22Head%22%3a0%2c%22PDOP%22%3a20%2c%22PosAcc%22%3a18%2c%22GpsStat%22%3a3%2c%22FType%22%3a0%7d%2c%7b%22DIn%22%3a1%2c%22DOut%22%3a0%2c%22DevStat%22%3a6%2c%22FType%22%3a2%7d%2c%7b%22AnalogueData%22%3a%7b%224%22%3a18%2c%221%22%3a4203%2c%222%22%3a1236%2c%223%22%3a2133%7d%2c%22FType%22%3a6%7d%2c%7b%22DType%22%3a2%2c%22Data%22%3a%22AAAJtuE5%22%2c%22FType%22%3a3%7d%5d%7d%2c%7b%22SeqNo%22%3a35707%2c%22Reason%22%3a17%2c%22DateUTC%22%3a%222015-07-10+03%3a15%3a42%22%2c%22Fields%22%3a%5b%7b%22GpsUTC%22%3a%222015-07-10+02%3a39%3a52%22%2c%22Lat%22%3a-33.7900917%2c%22Long%22%3a150.8895239%2c%22Alt%22%3a97%2c%22Spd%22%3a0%2c%22SpdAcc%22%3a4%2c%22Head%22%3a0%2c%22PDOP%22%3a20%2c%22PosAcc%22%3a18%2c%22GpsStat%22%3a3%2c%22FType%22%3a0%7d%2c%7b%22DIn%22%3a1%2c%22DOut%22%3a0%2c%22DevStat%22%3a6%2c%22FType%22%3a2%7d%2c%7b%22AnalogueData%22%3a%7b%224%22%3a18%2c%221%22%3a4203%2c%222%22%3a1236%2c%223%22%3a2132%7d%2c%22FType%22%3a6%7d%2c%7b%22DType%22%3a2%2c%22Data%22%3a%22AAAJtuE5%22%2c%22FType%22%3a3%7d%5d%7d%2c%7b%22SeqNo%22%3a35708%2c%22Reason%22%3a17%2c%22DateUTC%22%3a%222015-07-10+03%3a15%3a44%22%2c%22Fields%22%3a%5b%7b%22GpsUTC%22%3a%222015-07-10+02%3a39%3a52%22%2c%22Lat%22%3a-33.7900917%2c%22Long%22%3a150.8895239%2c%22Alt%22%3a97%2c%22Spd%22%3a0%2c%22SpdAcc%22%3a4%2c%22Head%22%3a0%2c%22PDOP%22%3a20%2c%22PosAcc%22%3a18%2c%22GpsStat%22%3a3%2c%22FType%22%3a0%7d%2c%7b%22DIn%22%3a1%2c%22DOut%22%3a0%2c%22DevStat%22%3a6%2c%22FType%22%3a2%7d%2c%7b%22AnalogueData%22%3a%7b%224%22%3a18%2c%221%22%3a4203%2c%222%22%3a1237%2c%223%22%3a2139%7d%2c%22FType%22%3a6%7d%2c%7b%22DType%22%3a2%2c%22Data%22%3a%22AAAJtuE5%22%2c%22FType%22%3a3%7d%5d%7d%2c%7b%22SeqNo%22%3a35709%2c%22Reason%22%3a17%2c%22DateUTC%22%3a%222015-07-10+03%3a15%3a46%22%2c%22Fields%22%3a%5b%7b%22GpsUTC%22%3a%222015-07-10+02%3a39%3a52%22%2c%22Lat%22%3a-33.7900917%2c%22Long%22%3a150.8895239%2c%22Alt%22%3a97%2c%22Spd%22%3a0%2c%22SpdAcc%22%3a4%2c%22Head%22%3a0%2c%22PDOP%22%3a20%2c%22PosAcc%22%3a18%2c%22GpsStat%22%3a3%2c%22FType%22%3a0%7d%2c%7b%22DIn%22%3a1%2c%22DOut%22%3a0%2c%22DevStat%22%3a6%2c%22FType%22%3a2%7d%2c%7b%22AnalogueData%22%3a%7b%224%22%3a18%2c%221%22%3a4203%2c%222%22%3a1237%2c%223%22%3a2144%7d%2c%22FType%22%3a6%7d%2c%7b%22DType%22%3a2%2c%22Data%22%3a%22AAAJtuE5%22%2c%22FType%22%3a3%7d%5d%7d%5d%7d";
            alert(jsonString);
            $.ajax({
                url: 'Handler.ashx',
                type: 'post',
                async: false,
                contentType: 'application/json; charset=utf-8',
                data: jsonString,
                dataType: 'json',
                success: function (result) {
                    // alert('success');
                },
                error: function (result) {
                    //  alert('failed');
                }
            });
            //  });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input type="submit" id="RunAjax" value="Run Ajax" />
    </div>
    </form>
</body>
</html>
