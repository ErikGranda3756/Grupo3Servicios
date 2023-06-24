/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ANTHONY
 */
public class personaDao {
      private static final String DB_URL = "jdbc:mysql://us-cdbr-east-06.cleardb.net:3306/heroku_0042041d0341cac";
    private static final String DB_USERNAME = "bcbf4af7a4e128";
    private static final String DB_PASSWORD = "a0771e1d";

    public List<Persona> getAllProducts() {
        List<Persona> products = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM personas");
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Persona product = new Persona();
                product.setCedula(rs.getString("cedula"));
                product.setNombre(rs.getString("nombre"));
                product.setApellido(rs.getString("apellido"));
                product.setEdad(rs.getInt("edad"));

                products.add(product);

                System.out.println(products);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public void insertProduct(Persona product) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                PreparedStatement stmt = conn.prepareStatement("INSERT INTO personas (cedula, nombre, apellido, edad) VALUES (?, ?,?,?)")) {
            stmt.setString(1, product.getCedula());
            stmt.setString(2, product.getNombre());
            stmt.setString(3, product.getApellido());
            stmt.setInt(4, product.getEdad());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Persona product) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement("UPDATE personas SET NOMBRE = ? , APELLIDO = ? , EDAD = ? WHERE CEDULA = ?")) {
            stmt.setString(4, product.getCedula());
            stmt.setString(1, product.getNombre());
            stmt.setString(2, product.getApellido());
            stmt.setInt(3, product.getEdad());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(String cedula) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM personas WHERE cedula = ?")) {
            stmt.setString(1, cedula);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Persona getProductById(String id) {
        Persona product = null;
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM personas WHERE cedula = ?")) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new Persona();
                    product.setCedula(rs.getString("cedula"));
                    product.setNombre(rs.getString("nombre"));
                    product.setApellido(rs.getString("apellido"));
                    product.setEdad(rs.getInt("edad"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
}
