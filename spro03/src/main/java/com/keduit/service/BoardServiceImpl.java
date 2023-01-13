package com.keduit.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.keduit.domain.BoardVO;
import com.keduit.domain.Criteria;
import com.keduit.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@ToString
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardMapper mapper;
	
	@Override
	public Long register(BoardVO board) {
		log.info("--------register--------" + board);
		int result = mapper.insertSelectKey(board);
		log.info("---------게시물 등록 상태 : " + result);
		return board.getBno();
	}
	@Override
	public BoardVO get(Long bno) {
		log.info("get service ---------------");
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify service-=--------------");
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove service=----------------");
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList service------------");
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("getTotalCount service-----------");
		return mapper.getTotalCount(cri);
	}
	
	

}
