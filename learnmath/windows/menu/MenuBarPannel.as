﻿package learnmath.windows.menu{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.display.*;
import flash.text.*;
import flash.events.*;
import learnmath.windows.*;
import learnmath.windows.elements.*;
import learnmath.windows.util.*;


public class MenuBarPannel extends BorderPannel{

	private var menuGroupPannel:MenuGroupPannel;
	private var currentButonMC:MovieClip;


	public function MenuBarPannel(_parent:MovieClip, _x:int, _y:int, _width:int, menuBar:MenuBar){
		super(_parent, _x, _y, _width, 22);
		var tf:TextFormat = ConfigManager.getTextFormatForMenu();
		
		pannel.graphics.lineStyle();
		pannel.graphics.beginFill(0xd4cfc9);   
		pannel.graphics.drawRect(0, 0, width, 20);   
		pannel.graphics.endFill();
		
		var xItem:int=0;
		var items:Array = menuBar.menuList;
		for(var i=0; i<items.length; i++){
			var w = addMenuOnMenuBar(pannel, items[i], xItem, tf);
			xItem = xItem + w;
		}
		pannel.graphics.lineStyle(1,0x847f7b);
		pannel.graphics.moveTo(0,20);
		pannel.graphics.lineTo(width, 20);
		pannel.graphics.lineStyle(1,0xffffff);
		pannel.graphics.moveTo(0,21);
		pannel.graphics.lineTo(width, 21);

		parent.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
		
	}
	
	private function addMenuOnMenuBar(menuBarMc:MovieClip, menuGroup:MenuGroup, _x:int, tf:TextFormat):int{
		var widthMenu:int = TextUtil.getWidth(menuGroup.name, tf) + 10;
		var item:MovieClip = new MovieClip();
		item.mouseChildren = false;
		item.menuGroup = menuGroup;
		item.maxWidth = widthMenu;
		
		item.x = _x;
		item.y = 1;
		
		item.graphics.lineStyle();
		item.graphics.beginFill(0xd4cfc9);   
		item.graphics.drawRect(0, 0, widthMenu-1, 18);   
		item.graphics.endFill();
		
		item.addEventListener(MouseEvent.MOUSE_OVER, drawOver);
		item.addEventListener(MouseEvent.MOUSE_OUT, drawOut);
		item.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
		
		var t:TextField = new TextField();
		t.defaultTextFormat = tf;
		t.text = menuGroup.name;
		t.x = 5;
		t.width = widthMenu-8;
		t.height = 18
		item.addChild(t);

		menuBarMc.addChild(item);
		return widthMenu + 1;
	}

	private function clicked(event:MouseEvent):void {
		if(currentButonMC==null && menuGroupPannel!=null){
			removeSubmenu();
			return;
		}
		if(currentButonMC==null){
			return;
		}
		removeSubmenu();
		drawSubmenu();
	}

	private function drawOut(event:MouseEvent):void {
		var mc = event.target;
		drawNormal(mc);
		currentButonMC = null;
	}
	
	private function drawNormal(mc:MovieClip):void {
		if(mc==null) return;
		mc.graphics.lineStyle();
		mc.graphics.beginFill(0xd4cfc9);   
		mc.graphics.drawRect(0, 0, mc.maxWidth-1, 18);   
		mc.graphics.endFill();
	}
	
	
	private function drawOver(event:MouseEvent):void {
		var mc = event.target;
		if(mc==currentButonMC) return;

		currentButonMC = mc;
		if(menuGroupPannel==null){
			drawButtonUP(mc);
		}else{
			drawButtonDOWN(mc);
			if(menuGroupPannel!=null){
				parent.removeChild(menuGroupPannel.pannel);
				menuGroupPannel = null;
			}
			if(mc.menuGroup.itemList.length>0){
				menuGroupPannel = new MenuGroupPannel(parent, pannel.x+ mc.x, pannel.y+19, mc.menuGroup, this);
			}
		}
	}		
	

	private function drawButtonUP(mc:MovieClip):void {
		mc.graphics.lineStyle(1,0xffffff);
		mc.graphics.moveTo(0,0);
		mc.graphics.lineTo(mc.maxWidth-1, 0);
		mc.graphics.moveTo(0,0);
		mc.graphics.lineTo(0, 17);
		
		mc.graphics.lineStyle(1,0x847f7b);
		mc.graphics.moveTo(mc.maxWidth-2, 17);
		mc.graphics.lineTo(mc.maxWidth-2, 0);
		mc.graphics.moveTo(mc.maxWidth-1, 17);
		mc.graphics.lineTo(0, 17);
	}		
	
	private function drawButtonDOWN(mc:MovieClip):void {
		mc.graphics.lineStyle(1,0x433e3a);
		mc.graphics.moveTo(0,0);
		mc.graphics.lineTo(mc.maxWidth-1, 0);
		mc.graphics.moveTo(0,0);
		mc.graphics.lineTo(0, 17);

		mc.graphics.lineStyle(1,0xffffff);
		mc.graphics.moveTo(mc.maxWidth-2, 17);
		mc.graphics.lineTo(mc.maxWidth-2, 0);
		mc.graphics.moveTo(mc.maxWidth-1, 17);
		mc.graphics.lineTo(0, 17);
	}		

	public function removeSubmenu():void {
		if(menuGroupPannel!=null){
			parent.removeChild(menuGroupPannel.pannel);
			menuGroupPannel = null;
			drawNormal(currentButonMC);
		}		
	}
	
	private function drawSubmenu():void {
		drawButtonDOWN(currentButonMC);
		if(currentButonMC.menuGroup.itemList.length>0){
			menuGroupPannel = new MenuGroupPannel(parent, pannel.x+ currentButonMC.x, pannel.y+19, currentButonMC.menuGroup, this);
		}		
	}

	public function menuClicked(id:String):void {
		removeSubmenu();
		pannel.dispatchEvent(new MenuCustomEvent(id));
	}

}

}