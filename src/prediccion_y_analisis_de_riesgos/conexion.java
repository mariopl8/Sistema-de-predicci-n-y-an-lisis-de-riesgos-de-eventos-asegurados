/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prediccion_y_analisis_de_riesgos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mariopl
 */
public class conexion {
    private Connection cn;
    
    public conexion(){
         try {
            // Nota: Para MySQL 8.x usa "com.mysql.cj.jdbc.Driver"
            Class.forName("com.mysql.jdbc.Driver");
            cn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Proyecto_final",
                "root",
                ""
            );
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
     public Connection getConnection() {
        return cn;
    }
}
    

