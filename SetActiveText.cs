using UnityEngine;
using System.IO;
using System.Net;
using System.Text;
using TinyJson;
using System.Collections.Generic;

public class SetActiveText : MonoBehaviour {
private static readonly string server = "http://localhost/unity/index.php";
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

    // ****
    //static string login = null;
    //static string pass = null;
    //static string function = null;

    //public static string RegistrationToString(string login, string pass, string function) {
    //    StringBuilder builder = new StringBuilder();
    //    builder.Append(function + "#");
    //    builder.Append(login + "#");
    //    builder.Append(pass);
    //    return builder.ToString();
    //}

    //static string send_son = JsonUtility.ToJson(RegistrationToString(login, pass, function));

    //***

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
            json_send["json"] = "[{\"registration\":{\"login\":\"radalex\",\"password\":\"222\"}}]";
            //json_send["json"] = "[" + result + "]";
            Dictionary<string, object> auth_json = GetJSON(json_send);
            string json = (string)auth_json["json"];
            string result_json = (string)auth_json["result"];
            Debug.Log("json: " + json);
            Debug.Log("result: " + result_json);
        }



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
    }

	// Use this for initialization
	void Start () {
        StartClient();

    }
	
	// Update is called once per frame
	void Update () {
	}
}
