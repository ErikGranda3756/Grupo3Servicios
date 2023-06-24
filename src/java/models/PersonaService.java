/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author ANTHONY
 */
@Path("/persona")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PersonaService {
    private personaDao productDAO = new personaDao();

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Persona> getAllProducts() {
        return productDAO.getAllProducts();
    }
    
    @GET
    @Path("/{id}")
    public Response getProductById(@PathParam("id") String id) {
        Persona product = productDAO.getProductById(id);
        if (product != null) {
            return Response.ok(product).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @POST
    public Response addProduct(Persona product) {
        productDAO.insertProduct(product);
        return Response.status(Response.Status.CREATED).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateProduct(@PathParam("id") String id, Persona product) {
        Persona existingProduct = productDAO.getProductById(id);
        if (existingProduct != null) {
            product.setCedula(id);
            productDAO.updateProduct(product);
            return Response.ok().build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @DELETE
    @Path("/{id}")
    public Response deleteProduct(@PathParam("id") String id) {
        Persona existingProduct = productDAO.getProductById(id);
        if (existingProduct != null) {
            productDAO.deleteProduct(id);
            return Response.ok().build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

}