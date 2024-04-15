import org.eclipse.paho.client.mqttv3.MqttMessage;

import com.mysql.cj.xdevapi.Client;

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
        Connection conn = MySQL_Integration.createConnection(url,username,password);
        
        //CreateData(conn);
        installations_with_automations(conn,"2000-01-01","2029-3-31");
        //clients_by_package_type(conn,2);
        //Start Connection
            

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


    public static void CreateData(Connection conn){

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
            
            //TODO isto devia ser um proc or smth
            
            int in = 0;
            String Query;
            //Insert Clients
            for( int i = 1; i < 100; ++i ){

                String Name  = new String ( RD.GetFirstName() + " " + RD.GetMiddleName() );
                Query = new String( "INSERT INTO Clients( name\t, main_address\t ,\tcontact\t , NIF  \t)\n" + //
                "VALUES \t\n" + //
                "( \""+ Name +"\"\t, \""+RD.GetAddress()+"\" ,\""+Name.replace(' ', '.').toLowerCase()+'@'+RD.GetMailSufix()+"\", "+RD.GetNIF()+")");
                MySQL_Integration.executeUpdate(conn,Query);

                //ADD Installation Contracts and devices
                for( int j = 1; j < ( (int) (Math.random()*8) );++j ){
                    String RDate = new String(RD.GetStartDate()); 
                    in++;
                    Query = "INSERT INTO Installation (address, Client_idClient, TypeID)"+
                            "VALUES (\""+RD.GetAddress()+"\","+i+","+  (int) ( Math.random()*3 + 1) +")";//Trocar para o novo 
                    
                    MySQL_Integration.executeUpdate(conn,Query);

                    Query = "INSERT INTO DevicesInput (ModelID, InstallationDate, InstallationID, StateID, PowerConsumption, Eficiency) "+ 
                    "VALUES (5, '"+RDate+"',"+in+" ,"+( (int)Math.round(Math.random() + 1))+", NULL, NULL)";
                    MySQL_Integration.executeUpdate(conn,Query);
                    
                    //if( Math.random() < 0.95 ){
                        
                        Query = "INSERT INTO Contract (StartDate, ServiceDuration, ServiceDesc_Type, Installation_code)"+ 
                        " VALUES ('"+RDate+"', '"+RD.GetEndDate()+"', "+ RD.GetServType() +", "+in+")";
                        MySQL_Integration.executeUpdate(conn,Query);

                    //}

                    
                    for( int n = 1; n < ( (int) (Math.random()*8) );++n ) {
                        
                        Query = "INSERT INTO DevicesOutput (ModelID, InstallationDate, InstallationID, StateID, PowerConsumption, Eficiency) "+ 
                        "VALUES ("+( (int)(Math.random()*4 + 1 ))+", \""+RDate+"\","+in+" ,"+( (int)Math.round(Math.random() + 1))+", NULL, NULL)";
                        MySQL_Integration.executeUpdate(conn,Query);

                    }
                }
                
            }
            Query = new String("INSERT INTO Invoice (InvoiceNumber, Date, State, ContractID)"+
                                    "VALUES"+
                                    "	(822547, '2023-12-11', 1, 1),"+
                                    "	(801770, '2024-01-01', 1, 2),"+
                                    "	(951156, '2020-12-10', 1, 3),"+
                                    "	(852691, '2023-12-11', 1, 4),"+
                                    "	(169529, '2024-01-01', 0, 5),"+
                                    "	(416611, '2023-12-11', 0, 6),"+
                                    "	(106329, '2023-12-11', 0, 7);");
            MySQL_Integration.executeUpdate(conn,Query); 

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

    public static void  clients_by_package_type(Connection conn, int ServiceType) throws SQLException{
    
        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
            "SELECT cl.name, cl.main_address, i.address as Installation_Address, s.name"+
            "	FROM installation i"+
            "	INNER JOIN Clients 		cl ON cl.idClient = i.Client_idClient"+
            "	INNER JOIN Contract 	co ON i.code	  = co.Installation_code"+
            "	INNER JOIN ServiceDesc 	s  ON s.Type 	  = co.ServiceDesc_Type "+
            "	WHERE"+
            "		co.ServiceDesc_Type = "+ServiceType+";");
        //Process Result
        System.out.println("Name| main_address| Installation_Address| Plano");
        while (resultSet.next()) {
            System.out.println(
                resultSet.getString("cl.name")+'|'+
                resultSet.getString("cl.main_address")+'|'+
                resultSet.getString("Installation_Address")+'|'+
                resultSet.getString("s.name") );
            
        }
    }

    public static void clients_by_installation_type(Connection conn, String InstallationType) throws SQLException{
        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
                "SELECT c.name, c.Main_Address, i.code , i.address as Installation_Address"+
                "		FROM Clients c"+
                "		INNER JOIN installation i on c.idClient = i.Client_idClient "+
                "		INNER JOIN InstallationTypeDesc TD on TD.TypeID = i.TypeID"+
                "		WHERE"+
                "		TD.Name = \""+InstallationType+'\"'+
                "		ORDER BY"+
                "		name ASC;");
        //Process Result
        System.out.println("Name| Main Address| Installation_Address");
        while (resultSet.next()) {
            System.out.println(
                resultSet.getString("c.name")+'|'+
                resultSet.getString("c.main_address")+'|'+
                resultSet.getString("i.code")+'|'+
                resultSet.getString("Installation_Address") );
            
        }
    }

    public static void installation_devices(Connection conn, String StartDate, String EndDate,int InstallationCode) throws SQLException{

        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
                "SELECT i.address as Installation_address , dd.Model , d.InstallationDate, d.Description"+
                "		FROM DevicesAll d"+
                "        INNER JOIN Installation i  ON i.code 			= d.InstallationID "+
                "		INNER JOIN DeviceDesc 	dd ON dd.idDevice_desc 	= d.ModelID"+
                "        WHERE"+
                "			 i.code = "+InstallationCode+
                "			 and (d.InstallationDate >= \'"+StartDate+"\' and d.InstallationDate <= \'"+EndDate+"\');");
        
        //Process Result
        System.out.println("Installation_address| Model| InstallationDate | Description");
        while (resultSet.next()) {
            System.out.println(
                resultSet.getString("Installation_address")+'|'+
                resultSet.getString("Model")+'|'+
                resultSet.getString("InstallationDate")+'|'+
                resultSet.getString("Description") );
            
        }
    }

    public static void client_invoice_average(Connection conn, String StartDate, String EndDate, int ClientID) throws SQLException{

        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
                "SELECT cl.name, AVG(s.cost) as Average_Invoice_Value"+
                "		FROM Invoice inv"+
                "		INNER JOIN Contract 	co 	ON co.idContract = inv.ContractID"+
                "		INNER JOIN ServiceDesc 	s	ON s.Type 		 = co.ServiceDesc_Type "+
                "		INNER JOIN Installation i 	ON i.code 		 = co.Installation_code"+
                "		INNER JOIN Clients 		cl 	ON cl.idClient 	 = i.Client_idClient"+
                "		WHERE"+
                "			cl.idClient = "+ClientID+" and"+
                "			 (inv.Date >= \'"+StartDate+"\' and inv.Date <= \'"+EndDate+"\');");
        
        //Process Result
        System.out.println("Name | Average Invoice Cost");
        while (resultSet.next()) {
            System.out.println(
                resultSet.getString("cl.name")+'|'+
                resultSet.getString("Average_Invoice_Value") );
            
        }

    } 

    public static void installations_with_automations(Connection conn, String StartDate, String EndDate) throws SQLException{

        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
                    "SELECT i.address as addresses_with_automations, InstallationID"+
                    "		FROM Installation i"+
                    "		RIGHT JOIN DevicesALL d ON I.code = d.InstallationID -- Aqui não é igual fazer Inner??"+
                    "		WHERE"+
                    "		(d.InstallationDate >= \'"+StartDate+"\' and d.InstallationDate <= \'"+EndDate+"\') "+
                    "		GROUP BY"+
                    "		i.address;");
        
        //Process Result
        System.out.println("Address With Automations | InstallationID");
        while (resultSet.next()) {
            System.out.println(
                resultSet.getString("addresses_with_automations")+'|'+
                resultSet.getString("InstallationID") );
            
        }

    } 

    public static void total_clients_InvoiceState(Connection conn, String State) throws SQLException{

        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
                "SELECT cl.name, cl.main_address, i.address as Installation_Address, idesc.Description"+
                "	FROM installation i"+
                "	INNER JOIN Clients 			cl 		ON cl.idClient	 	= i.Client_idClient"+
                "	INNER JOIN Contract 		co  	ON i.code		 	= co.Installation_code"+
                "	INNER JOIN Invoice 			inv 	ON co.idContract 	= inv.ContractID"+
                "	INNER JOIN InvoiceStateDesc idesc 	ON idesc.StateID 	= inv.State"+
                "	WHERE"+
                "		idesc.Description = \""+State+'\"'+
                "	ORDER BY"+
                "		cl.name ASC;");
        
        //Process Result
        System.out.println("Name | Main Address | Installation Address | Invoice State");
        while (resultSet.next()) {
            System.out.println(
                resultSet.getString("cl.name")+'|'+
                resultSet.getString("cl.main_address")+'|'+
                resultSet.getString("Installation_Address")+'|'+
                resultSet.getString("idesc.Description")
                );
        }

    } 

    public static void total_Invoice_value_all_clients(Connection conn) throws SQLException{

        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
                "SELECT cl.name, idesc.Description as State , SUM(s.cost) as Invoice_Total"+
                "		FROM Invoice inv"+
                "		INNER JOIN Contract 		co 		ON idContract 	= inv.ContractID"+
                "		INNER JOIN ServiceDesc 		s 		ON s.Type 		= co.ServiceDesc_Type "+
                "		INNER JOIN Installation 	i 		ON i.code 		= co.Installation_code"+
                "		INNER JOIN Clients 			cl 		ON cl.idClient 	= i.Client_idClient"+
                "        INNER JOIN InvoiceStateDesc idesc 	ON inv.State 	= idesc.StateID"+
                "		GROUP BY"+
                "		cl.name"+
                "		ORDER BY"+
                "			cl.name ASC;");
        
        //Process Result
        System.out.println("Name | State | Invoice_Total");
        while (resultSet.next()) {
            System.out.println(
                resultSet.getString("cl.name")+'|'+
                resultSet.getString("State")+'|'+
                resultSet.getString("Installation_Address")+'|'+
                resultSet.getString("Invoice_Total")
                );
        }

    } 

    public static String get_num_client_installations(Connection conn,int ClientID) throws SQLException{

        ResultSet resultSet = MySQL_Integration.executeQuery(conn,
                "	SELECT COUNT(i.code) as NumClient"+
                "	FROM installation i"+
                "	INNER JOIN Clients cl ON cl.idClient = i.Client_idClient"+
                "	WHERE"+
                "		idClient = "+ClientID+";");
        
                resultSet.next();
                return resultSet.getString(1);

    } 
}















