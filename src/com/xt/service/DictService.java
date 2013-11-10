package com.xt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xt.domain.Dict;
import com.xt.persistence.DictMapper;

@Service
public class DictService {

	@Autowired
	private DictMapper dictMapper;

	/**
	 * eg.dictService.getDictByName(Dict.DEVICE),入参为枚举类型
	 * @param dictType 枚举类型
	 * @return
	 */
	public List<Dict> getDictByName(int dictType) {
		switch (dictType) {
		case Dict.DEVICE://设备类型
			return dictMapper.getDeviceType();
		case Dict.SENSOR://传感器类型
			return dictMapper.getSensorType();
		case Dict.HOIST://闸门启闭类型
			return dictMapper.getHoistType();
		case Dict.POWER://电源类型
			return dictMapper.getPowerType();
		case Dict.SLUICE://闸门类型
			return dictMapper.getSluiceType();
		case Dict.UNIT://单位类型
			return dictMapper.getSensorUnit();
		case Dict.DEVICE_STATUS://设备状态
			return dictMapper.getDeviceStatus();
		case Dict.VIDEO_PROVIDER://视频监控供应商类型
			return dictMapper.getVideoProvider();
		case Dict.PROTOCAL_TYPE://协议类型
			return dictMapper.getProtocalType();
		case Dict.COMM_TYPE://通讯方式，GPRS/电台等
			return dictMapper.getCommType();
		}
		return null;
	}
}
