package com.example.spring.salmanager.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("paycMenuDao")
public class PaycMenuDao {

	@Autowired
    private SqlSession sqlSession;
    private String nameSpaceName = "payc.";

    public List<HashMap<String, Object>> paycList(HashMap<String,String> map){
    	List<HashMap<String, Object>> list = this.sqlSession.selectList(nameSpaceName + "paycList", map);

        return list;
    }
    
    public void makePaycInsert(HashMap<String, String> map) {
    	
        this.sqlSession.insert(nameSpaceName+"makePaycInsert", map);
    }
    
    //---------------------------- 전체 계산 -------------------------
    public HashMap<String, Object> acalPayc(HashMap<String, Object> map) {   
    	
    	HashMap<String,Object> m1 = new HashMap<String,Object>();
    	List<HashMap<String,Object>> deduction= new ArrayList();
    
    	//List<HashMap<String, Object>> getBasicSal = this.sqlSession.selectList(nameSpaceName + "getEmpemno",map);
    	
    	deduction=(List<HashMap<String,Object>>) map.get("list");
    	
    
    	System.out.println("getMap : "+deduction);
    	//map.put("list", getEmpemnoSal);
    	//map.put("yymm",map.get("yymm"));
    	//System.out.println("getempemno : "+m1);
    	//HashMap<String, Object> m1 = new HashMap<String, Object>();
    	
    	int totaldamt = 0;
    	int totalaamt = 0;
    	int totalfamt = 0;
    	//System.out.println("PaycMenuDao : "+map);
    	for(int i=0; i<deduction.size(); i++) {
    		//String emym = map.get("yymm")+getEmpemnoSal.get(i).get("EMP_EMNO").toString(); // ex)201811 + emp_emno
    		int damt = 0;
    		int aamt = 0;    		
    		int famt = 0;
    		damt = 
    				Integer.parseInt((String) deduction.get(i).get("npen"))
    			   +Integer.parseInt((String) deduction.get(i).get("hfee"))
    			   +Integer.parseInt((String) deduction.get(i).get("efee"))
    			   +Integer.parseInt((String) deduction.get(i).get("itax"))
    			   +Integer.parseInt((String) deduction.get(i).get("ltax"));
    		
    		
    		aamt = Integer.parseInt((String) deduction.get(i).get("SEMP_SAL"))
     			   +Integer.parseInt((String) deduction.get(i).get("SEMP_TAMT"))
     			   +Integer.parseInt((String) deduction.get(i).get("SEMP_FDEX"))
     			   //+Integer.parseInt((String) deduction.get(i).get("SEMP_NW_CST"))
     			   //+Integer.parseInt((String) deduction.get(i).get("SEMP_BW_CST"))
    		 	   +Integer.parseInt((String) deduction.get(i).get("SEMP_CMC"));
    		
    		famt = damt + aamt;
    		totalaamt +=aamt;
    		//map.put("emym",emym);
    		//map.put("emp_emno",getEmpemnoSal.get(i).get("EMP_EMNO").toString());
    		
    	
    		m1.put("emym",deduction.get(i).get("emym"));
    		//System.out.println("getMap : "+m1);
    		
    		List<HashMap<String, Object>> searchEmym = this.sqlSession.selectList(nameSpaceName + "searchEmym",m1);
    		
    		
    		m1.put("yymm",map.get("yymm"));
    		m1.put("emp_emno",deduction.get(i).get("EMP_EMNO"));
    		
    		m1.put("sal",deduction.get(i).get("SEMP_SAL"));
    		
    		m1.put("tamt", deduction.get(i).get("SEMP_TAMT"));
    		m1.put("fdex",deduction.get(i).get("SEMP_FDEX"));
    		/*m1.put("snc",deduction.get(i).get("SEMP_NW_CST"));
    		m1.put("sbc",deduction.get(i).get("SEMP_BW_CST"));
    		m1.put("slc",deduction.get(i).get("SEMP_L_CST"));*/
    		m1.put("cmc",deduction.get(i).get("SEMP_CMC"));
    		
     		m1.put("npen",deduction.get(i).get("npen"));
    		m1.put("hfee",deduction.get(i).get("hfee"));
    		m1.put("efee",deduction.get(i).get("efee"));
    		m1.put("itax",deduction.get(i).get("itax"));
    		m1.put("ltax",deduction.get(i).get("ltax"));
    		m1.put("damt", String.valueOf(damt));
    		m1.put("aamt", String.valueOf(aamt));
    		m1.put("famt",String.valueOf(famt));
    		//m1.put("getMap", deduction.get(i));
    		
    		if(searchEmym.size() == 0) { //insert
    			
    			//System.out.println("m1 : " +m1);
    			//System.out.println("acalInsert m1 : "+m1);
    			this.sqlSession.insert(nameSpaceName+"acalInsert", m1);
    		}
    		else { //update
    			
    			//System.out.println("acalUpdate m1 : "+m1);
    			
    			this.sqlSession.update(nameSpaceName+"acalUpdate", m1);
    		}
    		
    		m1.clear();
    	}
    	
    	
    	map.put("yymm",map.get("yymm"));
    	map.put("totalaamt",totalaamt);
    	//System.out.println("map.get"+m1);
    	this.sqlSession.update(nameSpaceName+"payc_main_aamt",map);
    	
    	return map;
        //this.sqlSession.insert(nameSpaceName+"makePaycInsert", map);
    }
    
    //----------------------------계산에 필요한 사원코드, 급여조회------------------------------------------------------
    public HashMap<String, Object> getEmpSal(HashMap<String, Object> map) {
    	
    	List<HashMap<String, Object>> getEmpemnoSal = this.sqlSession.selectList(nameSpaceName + "getEmpemno",map);
    	map.put("list", getEmpemnoSal);
    	return map;
    }
    
    public HashMap<String, Object> getItax(HashMap<String, Object> map) {
    	
    	List<HashMap<String, Object>> getItax = this.sqlSession.selectList(nameSpaceName + "getitax",map);
    	map.put("itaxList", getItax);
    	//System.out.println("getItax" + getItax);
    	return map;
    }
    
    public HashMap<String, Object>  getfamilyNum(HashMap<String, Object> map) {
    	
    	List<HashMap<String, Object>> getfamilyNum = this.sqlSession.selectList(nameSpaceName + "getfamilyNum",map);
    	
    	map.put("number", getfamilyNum);
    	//System.out.println("getfamilyNum" + getfamilyNum);
    	return map;
    }
    
    
    public List<HashMap<String, Object>> selectPayc(HashMap<String, Object> map) {
    	
    	List<HashMap<String, Object>> list = this.sqlSession.selectList(nameSpaceName + "select_payc",map);
    	
    	return list;
    }
}
