
package com.learn.mycart.mail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class SingleSubmit {
    public static void sendMail(String recepient, String itemNumber, String pDesc, String vTitle, String price,
            String name, String locations, String alt, String quantity) throws Exception{
        System.out.println("Preparing to send email");
        Properties properties = new Properties();
        
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "east.EXCH092.serverdata.net");
        properties.put("mail.smtp.port", "587");
        
        
        final String myAccountEmail = "ordering.portal@dseincorporated.com";
        final String myAccountPassword = "Rackspace123!!";
       
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(myAccountEmail, myAccountPassword);
            }
        });
        
        Message message = prepareMessage(session, myAccountEmail, recepient, itemNumber, pDesc, vTitle, price,
        name, locations, alt, quantity);
        Transport.send(message);
        System.out.println("Message sent successfully");
    }
        private static Message prepareMessage(Session session, String myAccountEmail, String recepient,
               String itemNumber, String pDesc, String vTitle, String price, String name,
               String locations, String alt, String quantity){
            
        try{
            




;
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
            message.setSubject("Item Approved for "+locations);
            message.setContent(
                    "<table>"
                   +"<tr>"
                   +"<th>ITEM #</th>"
                   +"<th>DESCRIPTION</th>"
                   +"<th>VENDOR</th>"
                   +"<th>COST</th>"
                   +"<th>ORDERED BY</th>"
                   +"<th>LOCATION</th>"
                   +"<th>ALTERNATE ITEM</th>"
                   +"<th>QTY ORDERED</th>"
                   +"</tr>"
                   +"<tr>"
                   + "<td>"+itemNumber+"</td>"
                   + "<td>"+pDesc+"</td>"
                   + "<td>"+vTitle+"</td>"
                   + "<td><span>$"+price+"</span></td>"
                   + "<td>"+name+"</td>"
                   + "<td>"+locations+"</td>"
                   + "<td>"+alt+"</td>"
                   + "<td>"+quantity+"</td>"
                   +"</tr>"
                   
                   + "</table>","text/html"
           );
            return message;
        }catch (Exception ex){
            Logger.getLogger(JavaMailUtil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
