package es.uleam.servidor;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import es.uleam.common.IServidor;

public class Servidor implements IServidor{

	private Map<Integer, String> sesion_nombre = new HashMap<Integer, String>();
	private Map<String, Integer> nombre_sesion = new HashMap<String, Integer>();
	private Map<Integer, List<Integer>> contactos = new HashMap<Integer, List<Integer>>();
	private Map<Integer, List<Mensaje>> buffer = new HashMap<Integer, List<Mensaje>>();

	@Override
	public int autenticar(String nombre){
		int sesionUsuario = gestSesion();

		sesion_nombre.put(sesionUsuario,nombre);
		nombre_sesion.put(nombre,sesionUsuario);

		return sesionUsuario;
	}

	@Override
	public int agregar(String nombre, int sesion){
		if(!sesion_nombre.containsKey(sesion)){
			throw new RuntimeException("Sesion invalida");
		}

		if(!nombre_sesion.containsKey(nombre)){
			throw new RuntimeException(nombre+" no esta conectado");
		}

		List<Integer> misContactos = contactos.get(sesion);
		if(misContactos==null){
			misContactos = new LinkedList<Integer>();
			contactos.put(sesion,misContactos);
		}

		misContactos.add(nombre_sesion.get(nombre));
		return nombre_sesion.get(nombre);
	}

	@Override
	public void enviar(String mensaje, int sesionDe, int sesionA){
		if(!sesion_nombre.containsKey(sesionDe)){
			throw new RuntimeException("Sesion invalida");
		}

		if(!sesion_nombre.containsKey(sesionA)){
			throw new RuntimeException("Contacto no esta conectado");
		}

		if(!contactos.get(sesionDe).contains(sesionA)){		//en la cabecera de la función
			throw new RuntimeException(sesion_nombre.get(sesionA) + "No es parte de sus contactos");
		}

		List<Mensaje> mensajes=buffer.get(sesionA);

		if(mensajes == null){
			mensajes = new LinkedList<Mensaje>();
			buffer.put(sesionA,mensajes);
		}

		mensajes.add(new Mensaje(mensaje,sesion_nombre.get(sesionDe)));

	}

	@Override
	public List<Mensaje> recibir(int sesion){
		if(!sesion_nombre.containsKey(sesion)){
			throw new RuntimeException("Sesion invalidad");
		}

		return buffer.get(sesion);
	}

	private static int sesion = new Random().nextInt();	//variable estática

	public static int gestSesion(){
		return ++sesion;
	}

}