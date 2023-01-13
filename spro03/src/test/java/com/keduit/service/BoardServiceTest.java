package com.keduit.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.keduit.domain.BoardVO;
import com.keduit.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {

	@Autowired
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("test register");
		board.setContent("test register content");
		board.setWriter("tester");
		
		long bno = service.register(board);
		log.info("생성된 게시물 번호 =====> " + bno);
	}
	
	@Test
	public void testGetList() {
		Criteria cri = new Criteria();
		service.getList(cri).forEach(board -> log.info(board));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(19L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(19L);
		if(board == null) {
			return;
		}
		
		board.setTitle("modify한 제목");
		board.setContent("special한 modify해둔 content");
		board.setWriter("엘레강트");
		log.info("modify result===" + service.modify(board));
	}
	
	@Test
	public void testDelete() {
		log.info("remove result : " + service.remove(18L));
	}
}
