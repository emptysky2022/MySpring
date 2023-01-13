package com.keduit.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.keduit.domain.BoardVO;
import com.keduit.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testResult() {
		mapper.testTime();
	}
	
	@Test
	public void testGetList() {
		Criteria cri = new Criteria();
		mapper.getListWithPaging(cri).forEach(board -> {
			log.info(board);
		});
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("spring");
		board.setContent("xml파일에서 작동하는 insert문");
		board.setWriter("spring");
		mapper.insert(board);
		
		log.info("insert test --" + board);
	}
	
	@Test
	public void testInsert2() {
		BoardVO board = new BoardVO();
		board.setTitle("다음번호 확인");
		board.setContent("추가할 컨텐츠의 번호 확인");
		board.setWriter("me");
		mapper.insertSelectKey(board);
		log.info("insert2 test -- " + board);
	}
	
	@Test
	public void testRead() {
		BoardVO board = new BoardVO();
		board = mapper.read(12L);
		log.info("read test ------------- " + board);
	}
	
	@Test
	public void testDelete() {
		int result = mapper.delete(23L);
		log.info("delete test -------");
		log.info("delete 결과 : " + result);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setTitle("hello update!");
		board.setContent("업데이트 테스트");
		board.setWriter("수정자");
		board.setBno(12L);
		int result = mapper.update(board);
		
		log.info("update test ---------");
		log.info("update 결과 : " + result);
	}
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("테스트");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
	}
}
