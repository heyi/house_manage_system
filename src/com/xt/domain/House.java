package com.xt.domain;

import java.io.Serializable;
import java.sql.Date;

public class House implements Serializable {

	private static final long serialVersionUID = -9018962614676665874L;
	
	private String houseType;
	private String dealType;
	
	private Integer houseId;//序号
	private String houseName;//小区名称
	private String houseNo;//栋号及房号
	private Date dealTime;//成交时间
	private String cityNo;//所在区县代码
	private String locate;//房屋位置
	private String areaNo;//区域代码
	private String realUse;//实际用途
	private String businessState;//经营状态
	private String structure;//房屋结构
	private Float constructionArea;//建筑面积
	private Float poolArea;//公摊面积
	private String buildingDate;//建筑年代
	private String newSituation;//成新状况
	private String streetSide;//临街状况
	private String streetLength;//临街长度
	private String depth;//进深
	private Integer totalFloor;//总层数
	private Integer floor;//所在楼层
	private Float floorHeight;//层高
	private int decorateSituation;//装修情况
	private int landUseRight;//土地使用权类型
	private Date landExpiredDate;//土地终止日期
	private Float totalPrice;//成交总价
	private Float unitPrice;//成交单价
	private String hireState;//租赁情况
	private Float hirePrice;//租赁单价
	private String SupportingFacilities;//配套设施状况
	private String contactTel;//联系电话
	private int userId;//录入人编号
	private String collecter;//案例收集人
	private String remark;//备注
	private Double lng;//经度
	private Double lat;//纬度
	private Date insertTime;//采集时间
	
	private String img;//实物照片
	private String contract;//成交合同
	private Date hireExpiredDate;//租赁期限
	private Float hireUnitPrice;//租赁单价
	private Float transferFee;//转让费
	private Float deposit;//押金
	private Float propertyManagementFee;//物业管理费
	private String officeFacilities;//办公配套
	private String parkingFacilities;//停车配套
	private Float pilespacing;//柱距
	private int craneBeam;//有无行车梁
	private Float span;//跨度
	public String getHouseType() {
		return houseType;
	}
	public void setHouseType(String houseType) {
		this.houseType = houseType;
	}
	public String getDealType() {
		return dealType;
	}
	public void setDealType(String dealType) {
		this.dealType = dealType;
	}
	public Integer getHouseId() {
		return houseId;
	}
	public void setHouseId(Integer houseId) {
		this.houseId = houseId;
	}
	public String getHouseName() {
		return houseName;
	}
	public void setHouseName(String houseName) {
		this.houseName = houseName;
	}
	public String getHouseNo() {
		return houseNo;
	}
	public void setHouseNo(String houseNo) {
		this.houseNo = houseNo;
	}
	public Date getDealTime() {
		return dealTime;
	}
	public void setDealTime(Date dealTime) {
		this.dealTime = dealTime;
	}
	public String getCityNo() {
		return cityNo;
	}
	public void setCityNo(String cityNo) {
		this.cityNo = cityNo;
	}
	public String getLocate() {
		return locate;
	}
	public void setLocate(String locate) {
		this.locate = locate;
	}
	public String getAreaNo() {
		return areaNo;
	}
	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}
	public String getRealUse() {
		return realUse;
	}
	public void setRealUse(String realUse) {
		this.realUse = realUse;
	}
	public String getBusinessState() {
		return businessState;
	}
	public void setBusinessState(String businessState) {
		this.businessState = businessState;
	}
	public String getStructure() {
		return structure;
	}
	public void setStructure(String structure) {
		this.structure = structure;
	}
	public Float getConstructionArea() {
		return constructionArea;
	}
	public void setConstructionArea(Float constructionArea) {
		this.constructionArea = constructionArea;
	}
	public Float getPoolArea() {
		return poolArea;
	}
	public void setPoolArea(Float poolArea) {
		this.poolArea = poolArea;
	}
	public String getBuildingDate() {
		return buildingDate;
	}
	public void setBuildingDate(String buildingDate) {
		this.buildingDate = buildingDate;
	}
	public String getNewSituation() {
		return newSituation;
	}
	public void setNewSituation(String newSituation) {
		this.newSituation = newSituation;
	}
	public String getStreetSide() {
		return streetSide;
	}
	public void setStreetSide(String streetSide) {
		this.streetSide = streetSide;
	}
	public String getStreetLength() {
		return streetLength;
	}
	public void setStreetLength(String streetLength) {
		this.streetLength = streetLength;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public Integer getTotalFloor() {
		return totalFloor;
	}
	public void setTotalFloor(Integer totalFloor) {
		this.totalFloor = totalFloor;
	}
	public Integer getFloor() {
		return floor;
	}
	public void setFloor(Integer floor) {
		this.floor = floor;
	}
	public Float getFloorHeight() {
		return floorHeight;
	}
	public void setFloorHeight(Float floorHeight) {
		this.floorHeight = floorHeight;
	}
	public int getDecorateSituation() {
		return decorateSituation;
	}
	public void setDecorateSituation(int decorateSituation) {
		this.decorateSituation = decorateSituation;
	}
	public int getLandUseRight() {
		return landUseRight;
	}
	public void setLandUseRight(int landUseRight) {
		this.landUseRight = landUseRight;
	}
	public Date getLandExpiredDate() {
		return landExpiredDate;
	}
	public void setLandExpiredDate(Date landExpiredDate) {
		this.landExpiredDate = landExpiredDate;
	}
	public Float getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Float totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Float getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(Float unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getHireState() {
		return hireState;
	}
	public void setHireState(String hireState) {
		this.hireState = hireState;
	}
	public Float getHirePrice() {
		return hirePrice;
	}
	public void setHirePrice(Float hirePrice) {
		this.hirePrice = hirePrice;
	}
	public String getSupportingFacilities() {
		return SupportingFacilities;
	}
	public void setSupportingFacilities(String supportingFacilities) {
		SupportingFacilities = supportingFacilities;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getCollecter() {
		return collecter;
	}
	public void setCollecter(String collecter) {
		this.collecter = collecter;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Date getInsertTime() {
		return insertTime;
	}
	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getContract() {
		return contract;
	}
	public void setContract(String contract) {
		this.contract = contract;
	}
	
	public Date getHireExpiredDate() {
		return hireExpiredDate;
	}
	public void setHireExpiredDate(Date hireExpiredDate) {
		this.hireExpiredDate = hireExpiredDate;
	}
	public Float getHireUnitPrice() {
		return hireUnitPrice;
	}
	public void setHireUnitPrice(Float hireUnitPrice) {
		this.hireUnitPrice = hireUnitPrice;
	}
	public Float getTransferFee() {
		return transferFee;
	}
	public void setTransferFee(Float transferFee) {
		this.transferFee = transferFee;
	}
	public Float getDeposit() {
		return deposit;
	}
	public void setDeposit(Float deposit) {
		this.deposit = deposit;
	}
	public Float getPropertyManagementFee() {
		return propertyManagementFee;
	}
	public void setPropertyManagementFee(Float propertyManagementFee) {
		this.propertyManagementFee = propertyManagementFee;
	}
	public String getOfficeFacilities() {
		return officeFacilities;
	}
	public void setOfficeFacilities(String officeFacilities) {
		this.officeFacilities = officeFacilities;
	}
	public String getParkingFacilities() {
		return parkingFacilities;
	}
	public void setParkingFacilities(String parkingFacilities) {
		this.parkingFacilities = parkingFacilities;
	}
	public Float getPilespacing() {
		return pilespacing;
	}
	public void setPilespacing(Float pilespacing) {
		this.pilespacing = pilespacing;
	}
	public int getCraneBeam() {
		return craneBeam;
	}
	public void setCraneBeam(int craneBeam) {
		this.craneBeam = craneBeam;
	}
	public Float getSpan() {
		return span;
	}
	public void setSpan(Float span) {
		this.span = span;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
