<!--
/**
 * @author ���ǻ� (ggonsika@naver.com, http://blog.naver.com/ggonsika)
 * 
 * �� ���� �̸��� �������� �����ֽð� (^^)
 * ����� ������� ������ ���ϼŵ� ���� ó���� ��������ϸ�
 * ����ī��, ���� ������ �ʼ��Դϴ�.
 */

/**
 * [����]
 * java �� Map �������̽��� �����ϰ� ��밡���ϴ�.
 * ���������� key=value ���¸� javascript �� Object �� �̿��Ͽ� �����ߴ�.
 *
 * [������]
 * 1. JMap()
 *
 * [Public Method]
 *   - map.get(key):object - ������ key �� �ش��ϴ� value �� ��´�
 *   - map.remove(key):void - ������ key �� �ش��ϴ� value �� �����Ѵ�
 *   - map.keys():array - ��ü Key ������ �迭�� ��´�
 *   - map.values():array - ���� ��ü ������ �迭�� ��´�
 *   - map.containsKey(key):boolean - key �� ���ԵǾ� �ִٸ� true �� ��ȯ�Ѵ�.
 *   - map.isEmpty():boolean - ���� ����ִٸ� true �� ��ȯ�Ѵ�.
 *   - map.clear():void - ���� ����
 *   - map.size():int - ���� ũ�⸦ ��´�
 *   - map.getObject():object - MapData Object �� ��´�
 *
 * [��뿹]
 * <html>
 * <head>
 * <script language=javascript src="JMap.js"></script>
 * <script language=javascript>
 * <!--
 *     var map = new JMap();
 *     map.put("a", "11");
 *     map.put("b", "22");
 *     map.put("c", "33");
 *     
 *     alert("map.size()=" + map.size());
 *     alert("map.isEmpty()=" + map.isEmpty());
 *     alert("map.get('a')=" + map.get('a'));
 *     alert("map.containsKey('a')=" + map.containsKey('a'));
 *     map.remove('a');
 *     alert("map.remove('a')");
 *     alert("map.containsKey('a')=" + map.containsKey('a'));
 *     alert("map.get('a')=" + map.get('a'));
 *     alert("map.keys()=" + map.keys());
 *     alert("map.values()=" + map.values());
 *     map.clear();
 *     alert("map.clear()");
 *     alert("map.size()=" + map.size());
 *     alert("map.getObject()=" + map.getObject());
 * -->
 * </script>
 * </head>
 * </html>
 * 
 */
var JMap = function (obj) {
    
	/* Map Data ���� ��ü */
	var mapData = (obj != null) ? cloneObject(obj) : new Object();
	
	/**
	 * public
	 * ������ key �� �ش��ϴ� value �� �ִ´�
	 * @param key Ű
	 * @param value ��
	 */
	this.put = function(key, value) {
		mapData[key] = value;
	}
	
	/**
	 * public
	 * ������ key �� �ش��ϴ� value �� ��´�
	 * @param key Ű��
	 * @return Ű�� �ش��ϴ� ��
	 */
	this.get = function(key) {
		return mapData[key];
	}
	
	/**
	 * public
	 * ������ key �� �����Ѵ�
	 * @param key Ű��
	 */
	this.remove = function(key) {
		for (var tKey in mapData) {
			if (tKey == key) {
				delete mapData[tKey];
				break;
			}
		}
	}
	
	/**
	 * public
	 * ���� ��ü Key ������ �迭�� ��´�
	 * @return key ������ Array
	 */
	this.keys = function() {
		var keys = [];
		for (var key in mapData) {
			keys.push(key);
		}
		return keys;
	}
	
	/**
	 * public
	 * ���� ��ü ������ �迭�� ��´�.
	 * @return key ������ Array
	 */
	this.values = function() {
		var values = [];
		for (var key in mapData) {
			values.push(mapData[key]);
		}
		return values;
	}
	
	/**
	 * public
	 * Map�� key �� ���ԵǾ� �ִٸ� true
	 * @param key Ű��
	 * @return Ű�� ���� ����
	 */
	this.containsKey = function(key) {
		for (var tKey in mapData) {
			if (tKey == key) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * public
	 * Map�� ����ִٸ� true
	 * @return ���� ��������� ����
	 */
	this.isEmpty = function() {
		return (this.size() == 0);
	}
	
	/**
	 * public
	 * Map�� ����
	 */
	this.clear = function() {
		for (var key in mapData) {
			delete mapData[key];
		}
	}
	
	/**
	 * public
	 * Map�� ũ�⸦ ��´�
	 * @return ���� ũ��
	 */
	this.size = function() {
		var size = 0;
		for (var key in mapData) {
			size++;
		}
		return size;
	}
	
	/**
	 * public
	 * Object ��ü�� ��´� (JSON �� ���� �ܺ� �۾��� ����..)
	 * @return ���ڿ�
	 */
	this.getObject = function() {
		return cloneObject(mapData);
	}
	
	/**
	 * private
	 * Object ��ü�� ��´� (JSON �� ���� �ܺ� �۾��� ����..)
	 * @return ���ڿ�
	 */
	var cloneObject = function(obj) {
		var cloneObj = {};
		for (var attrName in obj) {
			cloneObj[attrName] = obj[attrName];
		}
		return cloneObj;
	}
} // End of JMap Class

//-->


