using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Net.Sockets;

namespace lab4.Model
{
    internal class StateObject
    {
        //encapsulate the state and context information related to a specific connection in the asynchronous socket operations
        public Socket socket = null;
        public const int BUFFER_SIZE = 512;
        public byte[] receiveBuffer = new byte[BUFFER_SIZE];
        public StringBuilder responseContent = new StringBuilder();
        public int clientID;
        public string hostname;
        public string endpointPath;
        public IPEndPoint remoteEndPoint;
        //used for signaling completion of specific asynchronous operations.
        //to synchronize the flow of execution in asynchronous socket operations
        public ManualResetEvent connectDone = new ManualResetEvent(false);
        public ManualResetEvent sendDone = new ManualResetEvent(false);
        public ManualResetEvent receiveDone = new ManualResetEvent(false);
    }
}
