package com.JAVA.DAO;

import java.sql.SQLException;
import java.util.List;

import com.JAVA.Beans.Event;

public interface EventDAO {

    void createEvent(Event event) throws SQLException;

    void updateEvent(Event event) throws SQLException;

    void deleteEvent(int idEvent) throws SQLException;

    List<Event> getAllEvents() throws SQLException;

    List<Event> getEventsByCategory(String category) throws SQLException;

	Event getEventById(int idEvent) throws DAOException;

}


