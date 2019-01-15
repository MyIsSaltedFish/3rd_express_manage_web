package com.qf.express.manage.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.qf.express.common.AppResult;
import com.qf.express.common.DataGridResult;
import com.qf.express.manage.client.BcRegion;
import com.qf.express.manage.client.BcSubarea;
import com.qf.express.manage.client.RegionService;
import com.qf.express.utils.FileUtils;
import com.qf.express.utils.PinYin4jUtils;

@Controller
public class RegionAction {
	
	@Autowired 
	private RegionService regsionService;
	
	//Excel文件上传到数据库
	@RequestMapping(value="/region/uploadregion",method=RequestMethod.POST)
	@ResponseBody
	public AppResult uploadregion(MultipartFile myfile) throws IOException {
		System.out.println(myfile.getOriginalFilename());
		HSSFWorkbook workbook = null;
		//整个Excel文件
		try {
			workbook = new HSSFWorkbook(myfile.getInputStream());
			//获得第一页数据
			HSSFSheet sheet = workbook.getSheetAt(0);
			List<BcRegion> rs = new ArrayList<>();
			//获得行的集合
			for (Row row : sheet) {
				int rowNum = row.getRowNum();
				if(rowNum==0) {
					continue;
				}
				String shortcode = "";
				BcRegion rg = new BcRegion();
				for (Cell cell : row) {
					int index = cell.getColumnIndex();
					if(index==0) {
						rg.setId(cell.getStringCellValue());
					}else if(index==1) {
						rg.setProvince(cell.getStringCellValue());	
					}else if(index==2) {
						shortcode += cell.getStringCellValue().substring(0, cell.getStringCellValue().length()-1);
						rg.setCity(cell.getStringCellValue());
					}else if(index==3) {
						shortcode += cell.getStringCellValue().substring(0, cell.getStringCellValue().length()-1);
						rg.setDistrict(cell.getStringCellValue());
					}else if(index==4) {
						rg.setPostcode(cell.getStringCellValue());
					}
				}
				rg.setShortcode(PinYin4jUtils.getHeadByString1(shortcode, false));
				String cityqp = PinYin4jUtils.hanziToPinyin(rg.getCity(), "");
				rg.setCitycode(cityqp);
				rs.add(rg);
			}
			System.out.println(rs);
			regsionService.addRegions(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			workbook.close();
		}
		return new AppResult(200, "上传成功", null);
	}
	//从数据库中下载Excel
	@RequestMapping(value="/region/downloadregion")
	public void downloadregion(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		//1 查询所有区域集合
		List<BcRegion> list = regsionService.findAllRegion();
		/*for (BcRegion bcRegion : list) {
			System.out.println(bcRegion);
		}*/
		//2 生成workbook
		HSSFWorkbook workbook = new HSSFWorkbook();
		//3 为workbook生成sheet
		HSSFSheet sheet = workbook.createSheet("行政区域");
		//4 为sheet生成头行
		HSSFRow headRow = sheet.createRow(0);
		headRow.createCell(0).setCellValue("区域编号");
		headRow.createCell(1).setCellValue("省份");
		headRow.createCell(2).setCellValue("城市");
		headRow.createCell(3).setCellValue("区域");
		headRow.createCell(4).setCellValue("邮编");
		
		//5 遍历区域集合 生成数据行
		for (BcRegion bcRegion : list) {
			HSSFRow dataRow1 = sheet.createRow(sheet.getLastRowNum()+1);
			
			dataRow1.createCell(0).setCellValue(bcRegion.getId());
			dataRow1.createCell(1).setCellValue(bcRegion.getProvince());
			dataRow1.createCell(2).setCellValue(bcRegion.getCity());
			dataRow1.createCell(3).setCellValue(bcRegion.getDistrict());
			dataRow1.createCell(4).setCellValue(bcRegion.getPostcode());
		}
		//把workbook中的数据写回客户端
		//6 改变响应格式
		resp.setCharacterEncoding("UTF-8");
		//7改变响应格式
		resp.setContentType("application/vnd.ms-excel");
		//7.1 设置附件名字
		//如果是英文字母，这样的设置已经足够了
		/*String filename = "qy.xls";
		resp.addHeader("Content-Disposition", "attachment; filename=" + filename);*/
		//文件名是中文的时候  返回的时候 中文的名字 是有乱码的 产生的原因 是名字通过url传回 需要转成fileName = URLEncoder.encode(fileName, "UTF-8");
		/*String filename = "区域.xls";
		resp.addHeader("Content-Disposition", "attachment; filename=" + filename);*/
		//只能解决大部分浏览器，火狐浏览器无法解决返回的名字依旧是URLEncoder.encode(fileName, "UTF-8");
		String filename = "区域.xls";
		/*filename = URLEncoder.encode(filename, "UTF-8");
		resp.addHeader("Content-Disposition", "attachment; filename=" + filename);*/
		//最终
		//获得客户端浏览器类型		
		String agent = req.getHeader("User-Agent");
		resp.addHeader("Content-Disposition", "attachment; filename=" 
					+ FileUtils.encodeDownloadFilename(filename, agent));
		//8 写回去
		workbook.write(resp.getOutputStream());
	}
	//region/findRegion
	@RequestMapping(value="/region/findRegion",method=RequestMethod.POST)
	@ResponseBody
	public DataGridResult<BcRegion> findRegion(Integer page,Integer rows){
		System.out.println(page+":"+rows);
		return regsionService.findRegion(page,rows);
	}
	
	@RequestMapping(value="/subarea/findregionsbykeys",method=RequestMethod.POST)
	@ResponseBody
	public List<BcRegion> findRegionsByKeys(String q){
		return regsionService.findRegionsByKeys(q);
	}
	
	@RequestMapping(value="/base/addsubarea",method=RequestMethod.POST)
	@ResponseBody
	public AppResult addSubarea(BcSubarea subarea){
		System.out.println(subarea);
		return regsionService.addSubarea(subarea);
	}
	
	@RequestMapping(value="/base/findsubarea",method=RequestMethod.POST)
	@ResponseBody
	public DataGridResult<BcSubarea> findsubarea(Integer page,Integer rows,String regionId){
		System.out.println(page+":"+rows+":"+regionId);
		return regsionService.findSubarea(page, rows);
	}
	@RequestMapping(value="/base/delsubarea",method=RequestMethod.POST)
	@ResponseBody
	public AppResult delsubarea(String[] id){
		
		return regsionService.delSubarea(id);
	}
	
	@RequestMapping(value="/base/delregion",method=RequestMethod.POST)
	@ResponseBody
	public AppResult delregion(String[] id){
		
		return regsionService.delregion(id);
	}
	
	@RequestMapping(value="/base/addregion",method=RequestMethod.POST)
	@ResponseBody
	public AppResult addregion(BcRegion region){
		return regsionService.addregion(region);
	}
}
