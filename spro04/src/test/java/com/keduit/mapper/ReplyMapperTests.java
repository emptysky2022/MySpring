package com.keduit.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.keduit.domain.Criteria;
import com.keduit.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	private Long[] bnoArr = {1L, 3L, 5L, 6L, 7L};
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1,10).forEach(i -> {
			ReplyVO reply = new ReplyVO();
			
			reply.setBno(bnoArr[i%5]);
			reply.setReply("testCreate" + i);
			reply.setReplyer("replyer " + i);
			
			mapper.insert(reply);
		});
	}		
	
	@Test
	public void testRead() {
		Long rno = 3L;
		ReplyVO reply = mapper.read(rno);
		log.info("testRead " + reply);
	}
	
	@Test
	public void testDelete() {
		Long rno = 11L;
		log.info("testDelete " + mapper.delete(rno));
	}
	
	@Test
	public void testUpdate() {
		ReplyVO reply = new ReplyVO();
		
		reply.setRno(3L);
		reply.setReply("testUpdate");
		
		log.info("testUpdate " + mapper.update(reply));
	}
	
	@Test
	public void testGetList() {
		log.info("testGetList ");
		
		Criteria cri = new Criteria();
		List<ReplyVO> list = mapper.getListWithPaging(cri, bnoArr[2]);
		
		list.forEach(e -> log.info(e));
	}
	
	@Test
	public void testGetListWithPaging() {
		log.info("testGetListWithPaging");
		Criteria cri = new Criteria(2,10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 1114181L);
		replies.forEach(e -> log.info(e));
	}
}
