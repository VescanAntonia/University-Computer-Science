using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using lab4.Model;

namespace lab4.Utils
{
    internal class HttpUtils
    {
        public static readonly int HTTP_PORT = 80;

        public static string GetResponseBody(string responseContent)
        {
            //This method extracts the response body from the given response content
            var responseParts = responseContent.Split(new[] { "\r\n\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            return responseParts.Length > 1 ? responseParts[1] : "";
        }

        public static bool ResponseHeaderFullyObtained(string responseContent)
        {
            //This method checks if the response headers are fully obtained by looking for the end of a line of text and the start of a new one
            return responseContent.Contains("\r\n\r\n");
        }

        public static int GetContentLength(string responseContent)
        {
            //This method parses the Content-Length header from the response content and returns it as an integer
            var responseLines = responseContent.Split('\r', '\n');
            foreach (var responseLine in responseLines)
            {
                var headerDetails = responseLine.Split(':');
                if (headerDetails[0].CompareTo("Content-Length") == 0)
                {
                    return int.Parse(headerDetails[1]);
                }
            }

            return 0;
        }

        public static string GetRequestString(string hostname, string endpoint)
        {
            //This method generates an HTTP GET request string with the specified hostname and endpoint
            return "GET " + endpoint + " HTTP/1.1\r\n" +
                   "Host: " + hostname + "\r\n" +
                   "Content-Length: 0\r\n\r\n" +
                   "Content-Type: text/html";
        }

        public static void PrintResponse(StateObject state)
        {
            //This method prints each line of the response content to the console
            foreach (var i in state.responseContent.ToString().Split('\r', '\n'))
            {
                Console.WriteLine(i);
            }
        }
    }
}
