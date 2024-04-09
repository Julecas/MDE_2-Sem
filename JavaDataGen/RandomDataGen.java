import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;

public class RandomDataGen {

    private ArrayList<String> FirstNames;
    private ArrayList<String> MiddleNames;
    private ArrayList<String> address;
    private ArrayList<String> MailSufix;
    private ArrayList<String> Suppliers;

    public RandomDataGen( String FileFirstNames, String FileMiddletNames ){

        LoadNames(FileFirstNames, FileMiddletNames);
    }
    
    public RandomDataGen( String FileAddress){

        LoadAdress(FileAddress);
    }

    public RandomDataGen( String FileFirstNames, String FileMiddletNames, String FileAddress){
        
        LoadNames(FileFirstNames, FileMiddletNames);
        LoadAdress(FileAddress);
    }

    public RandomDataGen( String FileFirstNames, String FileMiddletNames, String FileAddress, String FileMail, String FileSuppliers){
        
        LoadNames(FileFirstNames, FileMiddletNames);
        LoadAdress(FileAddress);
        LoadMail(FileMail);
        LoadSupplieres(FileSuppliers);
    }

    public void LoadSupplieres(String FileName){
        try {

            File    f = new File( FileName );
            Scanner s = new Scanner(f);
            Suppliers = new ArrayList<String>();

            while( s.hasNextLine() ){
                Suppliers.add(s.nextLine());
            }
            
            s.close();
            
        } catch (Exception e) {

            System.out.println(e);
            return;
        }

    }

    public void LoadMail(String FileName){

        try {

            File    f = new File( FileName);
            Scanner s = new Scanner(f);
            MailSufix = new ArrayList<String>();

            while( s.hasNextLine() ){
                MailSufix.add(s.nextLine());
            }
            
            s.close();
            
        } catch (Exception e) {

            System.out.println(e);
            return;
        }
    }

    public void LoadNames( String FileFirstNames, String FileMiddletNames  ){

        try {

            File    ff  = new File( FileFirstNames);
            File    fm  = new File( FileFirstNames);
            Scanner sf  = new Scanner(ff);
            Scanner sm  = new Scanner(fm);
            FirstNames  = new ArrayList<String>();
            MiddleNames = new ArrayList<String>();
            
            while( sf.hasNextLine() ){
                FirstNames.add(sf.nextLine());
            }
            
            sf.close();
            
            while( sm.hasNextLine() ){
                MiddleNames.add(sm.nextLine());
            }
            
            sm.close();

        } catch (Exception e) {
            System.out.println(e);
            return;
        }
    }
    
    public void LoadAdress( String FileName ){

        try {

            File    f = new File( FileName);
            Scanner s = new Scanner(f);
            address   = new ArrayList<String>();

            while( s.hasNextLine() ){
                address.add(s.nextLine());
            }
            
            s.close();
            
        } catch (Exception e) {

            System.out.println(e);
            return;
        }
    }

    public String GetFirstName(){
        
        int r = (int) ( Math.random() *  FirstNames.size() ) ;

        return FirstNames.get( r );
    }

    public String GetMiddleName(){
        int r = (int) ( Math.random() *  MiddleNames.size() ) ;

        return MiddleNames.get( r );
    }

    public String GetAddress(){
        int r = (int) ( Math.random() *  address.size() ) ;

        return address.get( r );

    }

    public int GetNIF(){

        return (int) ( Math.random() *( 999999999 - 100000000) ) + 100000000 ; 

    }
    
    public int GetPhone(){

        return (int) ( Math.random() *( 999999999 - 900000000) ) + 900000000 ; 

    }

    public String GetStartDate(){

        return ""+ ((int) (Math.random()*(23) + 2000) ) + "-" +( (int)( Math.random()*11 + 1) ) +"-"+( (int) ( Math.random()*( 27 ) + 1) ) ;
    }

    public String GetEndDate(){

        return ""+ ((int) (Math.random()*(8) + 2023) ) + "-" +( (int)( Math.random()*11 + 1) ) +"-"+( (int) ( Math.random()*( 27 ) + 1) ) ;
    }

    public int GetServType(){

        return (int) ( Math.random()*(2) + 1  );

    }

    public String GetMailSufix(){
        int r = (int) ( Math.random() *  MailSufix.size() ) ;

        return MailSufix.get(r);
    }

}
