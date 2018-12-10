using UnityEngine;
using System.IO;
using System.Net;
using System.Text;
using TinyJson;
using System.Collections.Generic;

public class SetActiveText : MonoBehaviour {
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

    public static StringBuilder RegistrationToString() {
        string login = "radalex";
        string pass = "222";
        string function = "registration";
        StringBuilder builder = new StringBuilder();
        builder.Append(function + ",");
        builder.Append(login + ",");
        builder.Append(pass);
        return builder;
   }

    static StringBuilder send_son = RegistrationToString();

    public static void StartClient()
    {
        Dictionary<string, string> data = new Dictionary<string, string>();
        data["task"] = "auth.login";
        data["login"] = "kreng";
        data["password"] = "12345";
        Dictionary<string, object> auth = GetJSON(data);
        bool error = (bool)auth["error"];
        if (!error)
        {
            Dictionary<string, string> json_send = new Dictionary<string, string>();
            json_send["task"] = "hello.asd";
            json_send["access_token"] = (string)auth["access_token"];
            json_send["json"] = "[{\"json\":\"" + send_son + "\"}]";
            Dictionary<string, object> auth_json = GetJSON(json_send);
            string result_json = (string)auth_json["result"];
            Debug.Log("result: " + result_json);
        }
    }

	// Use this for initialization
	void Start () {
        StartClient();

    }
	
	// Update is called once per frame
	void Update () {
	}
}