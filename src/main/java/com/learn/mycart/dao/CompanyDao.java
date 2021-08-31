
package com.learn.mycart.dao;

import com.learn.mycart.entities.Company;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;


public class CompanyDao {
    private SessionFactory factory;

    public CompanyDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public List<Company> getCompanies(){
        Session s= this.factory.openSession();
        Query query = s.createQuery("from Company where status = 'active' ORDER BY companyName");
        List<Company> list= query.list();
        return list;
    }
    public Company getCompanyById(int cpid)
    {
        Company company = null;
        try {
            
            Session session = this.factory.openSession();
            company = session.get(Company.class, cpid);
            session.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return company;
    }
    public Company getCompanyByName(String name){
        Company company = null;
        try {
            String query="from Company where companyName =: n";
            Session session = this.factory.openSession();
            Query q= session.createQuery(query);
            q.setParameter("n", name);
            company =(Company) q.uniqueResult();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return company;
    }
    
      public Company getCompanyByNames(Company name){
        Company company = null;
        name.toString();
        try {
            String query="from Company where companyName =: n";
            Session session = this.factory.openSession();
            Query q= session.createQuery(query);
            q.setParameter("n", name);
            company =(Company) q.uniqueResult();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return company;
    }
      
      public Company getCompanyType(Company location){
        Company company = null;
     location.toString();
        try {
            String query="select type from Company where companyName =: n";
            Session session = this.factory.openSession();
            Query q= session.createQuery(query);
            q.setParameter("n", location);
            company =(Company) q.uniqueResult();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return company;
    }
      
       public List<Company> getInactiveCompanies(){
        Session s= this.factory.openSession();
        Query query = s.createQuery("from Company where status = 'inactive' ORDER BY companyName");
        List<Company> list= query.list();
        return list;
    }
      

}
