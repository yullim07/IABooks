package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface InterCommand {
	
	void execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
