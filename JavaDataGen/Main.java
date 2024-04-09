import org.eclipse.paho.client.mqttv3.MqttMessage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;


//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    
    static String url;
    static String username;  
    static String password;

    public static void main(String[] args) throws SQLException {

        url      = new String("jdbc:mysql://localhost/smart_buildingsdb?useSSL=false");
        username = new String("root");  
        password = new String("");
        // TIP Press <shortcut actionId="ShowIntentionActions"/> with your caret at the highlighted text
        // to see how IntelliJ IDEA suggests fixing it.
        System.out.println("MDE Lab1 - Welcome to the Java Project");
        CreateData();

        //MQTT Broker information
        //ATTENTION!!!
        //Comment the following line for testing WITHOUT real data
       // String broker = "tcp://192.168.250.201:1883";

        //Start Subscription
        //ATTENTION!!!
        //Comment the following line for testing WITHOUT real data
        //MQTTLibrary.createSubscriber(broker);
        
    }

    public static void messageReceived(String topic, MqttMessage message) {
        System.out.println("Message arrived. Topic: " + topic + " Message: " + message.toString());
    }


    public static void CreateData(){

        RandomDataGen RD = new RandomDataGen(
            "C:\\MDE\\Lab1\\Java\\src\\Data\\names.txt",
            "C:\\MDE\\Lab1\\Java\\src\\Data\\snames.txt",
            "C:\\MDE\\Lab1\\Java\\src\\Data\\moradas.txt",
            "C:\\MDE\\Lab1\\Java\\src\\Data\\MailSufix.txt",
            "C:\\MDE\\Lab1\\Java\\src\\Data\\Suppliers.txt"
        );

        //For testing only the MQTT connection, comment until start the MQTT part
        //Test database integration
        try {
            //Start Connection
            Connection conn = MySQL_Integration.createConnection(url,username,password);
            
            //TODO isto devia ser um proc or smth
            
                

            //Insert Clients
            for( int i = 1; i < 100; ++i ){

                String Name  = new String ( RD.GetFirstName() + " " + RD.GetMiddleName() );
                String Query = new String( "INSERT INTO Clients( name\t, main_address\t ,\tcontact\t , NIF  \t)\n" + //
                "VALUES \t\n" + //
                "( \""+ Name +"\"\t, \""+RD.GetAddress()+"\" ,\""+Name.replace(' ', '.').toLowerCase()+'@'+RD.GetMailSufix()+"\", "+RD.GetNIF()+")");
                MySQL_Integration.executeUpdate(conn,Query);

                //ADD Installation Contracts and devices
                for( int j = 1; j < ( (int) (Math.random()*8) );++j ){
                    String RDate = new String(RD.GetStartDate()); 

                    Query = "INSERT INTO Installation (address, Client_idClient, TypeID)"+
                            "VALUES (\""+RD.GetAddress()+"\","+i+","+  (int) ( Math.random()*3 + 1) +")";//Trocar para o novo 
                    
                    MySQL_Integration.executeUpdate(conn,Query);

                    Query = "INSERT INTO DevicesInput (ModelID, InstallationDate, InstallationID, StateID, PowerConsumption, Eficiency) "+ 
                    "VALUES (5, '"+RDate+"',"+j+" ,"+( (int)Math.round(Math.random() + 1))+", NULL, NULL)";
                    MySQL_Integration.executeUpdate(conn,Query);
                    
                    if( Math.random() < 0.95 ){
                        
                        Query = "INSERT INTO Contract (StartDate, ServiceDuration, ServiceDesc_Type, Installation_code)"+ 
                        " VALUES ('"+RDate+"', '"+RD.GetEndDate()+"', "+ RD.GetServType() +", "+j+")";
                        MySQL_Integration.executeUpdate(conn,Query);

                    }

                    
                    for( int n = 1; n < ( (int) (Math.random()*8) );++n ) {
                        
                        Query = "INSERT INTO DevicesOutput (ModelID, InstallationDate, InstallationID, StateID, PowerConsumption, Eficiency) "+ 
                        "VALUES ("+( (int)(Math.random()*4 + 1 ))+", \""+RDate+"\","+j+" ,"+( (int)Math.round(Math.random() + 1))+", NULL, NULL)";
                        System.out.println(Query);
                        MySQL_Integration.executeUpdate(conn,Query);

                    }
                }
            }
            

            /*
            //Execute Query
            ResultSet resultSet = MySQL_Integration.executeQuery(conn, "SELECT * FROM clients");
            //Process Result
            while (resultSet.next()) {
                //Process the result set
                System.out.println(resultSet.getString("idClient") + "\t" + resultSet.getString("name"));
            }
             */
            //Close Connection
            MySQL_Integration.closeConnection(conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}















