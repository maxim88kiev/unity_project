using UnityEngine;
//using System.Collections;
//using System;
using System.IO;
using System.Net;
//using System.Net.Sockets;
using System.Text;
//using System.Web;
using TinyJson;
using System.Collections.Generic;

public class SetActiveText : MonoBehaviour {

    //   private static string ip = "192.168.88.104";
    //   private static int port = 4455;

    //   private static Stream stream;
    //   private static StreamWriter writer;
    //   private static StreamReader reader;

    //   public GameObject TextCamera;
    //public GameObject TextLight;
    //public GameObject TextPanel;
















    //private static string server = "http://1385403.gagames.web.hosting-test.net/index.php?task=";

    //private static CookieContainer cookieContainer = new CookieContainer();

    //private static string GetJSONString(string uri)
    //{
    //    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
    //    request.Method = "GET";
    //    request.CookieContainer = cookieContainer;
    //    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; MyIE2;";
    //    request.Accept = "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application / x - shockwave - flash, application / vnd.ms - excel, application / vnd.ms - powerpoint, application / msword, */*";
    //    request.Headers.Add("Accept-Language", "en");
    //    request.ContentType = "text/plain";
    //    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
    //    StreamReader myStreamReader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
    //    return myStreamReader.ReadToEnd();
    //}

    //private static Dictionary<string, object> GetJSON(string task, Dictionary<string, string> data = null)
    //{
    //    string uri = server + task;
    //    if (data != null)
    //    {
    //        foreach (string key in data.Keys)
    //        {
    //            uri += string.Format("&{0}={1}", key, data[key]);
    //        }
    //    }
    //    var json = GetJSONString(uri).FromJson<object>();
    //    return (Dictionary<string, object>)json;
    //}





private static readonly string server = "http://1385403.gagames.web.hosting-test.net/index.php";

    private static CookieContainer cookieContainer = new CookieContainer();

    private static string GetJSONString(string postData = null)
    {
        try
        {
            var data = Encoding.ASCII.GetBytes(postData);
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(server);
            request.CookieContainer = cookieContainer;
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;
            using (var stream = request.GetRequestStream())
            {
                stream.Write(data, 0, data.Length);
            }
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
            return reader.ReadToEnd();
        }
        catch
        {
            return "{\"error\":true,\"error_msg\":\"the server does not respond\"}";
        }
    }

    private static Dictionary<string, object> GetJSON(Dictionary<string, string> data = null)
    {
        int count, i = 0;
        string postData = null;
        if (data != null)
        {
            postData = string.Empty;
            count = data.Keys.Count - 1;
            foreach (string key in data.Keys)
            {
                postData += string.Format("{0}={1}{2}", key, data[key], i < count ? "&" : string.Empty);
                i++;
            }
        }
        var json = GetJSONString(postData).FromJson<object>();
        return (Dictionary<string, object>)json;
    }


    public static void StartClient()
    {



        Dictionary<string, string> data = new Dictionary<string, string>();
        data["task"] = "login";
        data["login"] = "kreng";
        data["password"] = "1234";
        data["json"] = "[{\"materials\":{\"1\":\"1\",\"2\":\"1\"}}]";


        Dictionary<string, object> auth = GetJSON(data);
        bool error = (bool)auth["error"];
        if (!error)
        {
            string access_token = (string)auth["access_token"];
            string json = (string)auth["json"];
            Debug.Log("json: " + json);
            Debug.Log(access_token);

            //data = new Dictionary<string, string>();
            //data["access_token"] = access_token;
            //data["json"] = "[{\"materials\":{\"1\":\"1\",\"2\":\"1\"}}]";
            //Dictionary<string, object> new_json = GetJSON(data);
            //string json_2 = (string)new_json["json"];
            //Debug.Log("json: " + json_2);


        }





















        //TcpClient client = null;
        //    using (client = new TcpClient(ip, port))
        //    {
        //        Debug.Log("Connection was established");
        //        using (stream = client.GetStream())
        //        {
        //        writer = null;
        //            reader = null;

        //        try
        //        {
        //            writer = new StreamWriter(stream);
        //            reader = new StreamReader(stream);
        //        }
        //        catch (IOException exc)
        //        {
        //            Debug.Log(exc.Message);
        //        }


        //        //Debug.Log("Send Unity: (test/checkSynthesis)");
        //        //Debug.Log("Send Backend:" + Send("{\"path\":\"test/checkSynthesis\",\"materials\":{1:1,2:1}}"));


        //        //  json
        //        //string json = @"{""username"": ""1""}";

        //        //DataItem deserialized = JsonUtility.FromJson<DataItem>(json);

        //        //Debug.Log("Deserialized "+ deserialized.username);



        //        //Debug.Log("Starting auth");
        //        //Debug.Log("Send Backend_2:" + Send("{\"path\":\"auth/auth\",\"login\":\"radalex\",\"password\":\"222\"}"));

        //        //Debug.Log("Get materials...");
        //        //Send("{\"path\":\"objects/get\",\"location\":{\"lat\":50.405055,\"lon\":30.6190386}}");

        //        //Debug.Log("Collect material...");
        //        //Send("{\"path\":\"materials/collectMaterial\",\"geoMaterialId\":3,\"location\":{\"lat\":50.405055,\"lon\":30.6190386}}");

        //        //Debug.Log("Get collected materials...");
        //        //Send("{\"path\":\"materials/getCollectedMaterials\"}");

        //        //Debug.Log("Check synthesis"); // materials keys - material_id, values - count
        //        //Send("{\"path\":\"materials/checkSynthesis\",\"materials\":{1:1,2:1}}");

        //        //Debug.Log("Synthesize");
        //        //Send("{\"path\":\"materials/synthesize\",\"materials\":{1:1,2:1}}");
        //    }
        //    }
    }

    //public static String Send(String send)
    //{
    //    string received = null;

    //    writer.WriteLine(send);
    //    writer.Flush();
    //    //received = reader.ReadLine();
    //    Debug.Log("received: " + reader.ReadLine());

    //    return received;
    //}


	// Use this for initialization
	void Start () {
        StartClient();

    }
	
	// Update is called once per frame
	void Update () {
	}
}