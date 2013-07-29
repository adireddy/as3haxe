/**
 * In as3 packages should have open and close curly braces { }
 * In haxe package names should end with semi-colon;
*/
package com.ai.as3haxe;

import flash.display.Shape;
import flash.display.Sprite;
import flash.Lib;

/**
 * A simple class highlighting the differences between ActionScript 3.0 & Haxe 3.0
 * @author Adi
*/

/**
 * Class definition doesn't need access modifier in haxe (private, public, etc)
*/
class AS3Haxe {
	
	/**
	 * Default the access modifier is 'private' in Haxe
	*/
	var _boolean:Bool;		//Equivalent to 'Boolean' in ActionScript
	var _int:Int;			//Equivalent to 'int' in ActionScript
	var _float:Float;		//Equivalent to 'Number' in ActionScript
	var _dynamic:Dynamic;		//Equivalent to 'Object' in ActionScript
	var _array:Array<Dynamic>;	//Equivalent to 'Array' in ActionScript
	var _vector:Array<String>;	//Equivalent to 'Vector' in ActionScript
	
	//Constants: 'private const d:int = 5;' in ActionScript looks like below in Haxe
	inline private static var d:Int = 5;
	
	/**
	 * new() is the constructor function in Haxe where as in ActionScript function with class name will act as a constructor
	*/
	public function new() {
		trace("THIS IS CONSTRUCTOR");
		
		forLoops();		
		aboutReflectAndType();
		switchCase();
		typeInferenceAndCasting();
		hashTables();
		Reflect.makeVarArgs(restParameters)(1, 2, 3);
	}
	
	/**
	 * Return type is 'Void' in Haxe where as it's all lowercase 'void' in 
	*/
	function forLoops():Void {
		trace("FOR LOOPS");
		/**
		 * For loop was simplified in Haxe
		 * In ActionScript similar loop looks like 'for (var i:uint = 0; i < 100; i++)' 
		*/
		for (i in 0...100) {
			
		}
		
		/**
		 * For each loop is alos simplified in Haxe
		 * In ActionScript similar loop looks like 'for each (var value:String in items)' 
		*/
		var items:Array<Dynamic> = [1, 2, "three"];
		for (value in items) {
			trace(value);
		}
	}
	
	/**
	 * The Reflect class allows code to view and modify the structure of data types at runtime.
	 * The Type class contains functions that let us determine variable types and instantiate objects by name at runtime.
	 * Both classes are made up of static methods.
	*/
	function aboutReflectAndType():Void {
		trace("REFLECT AND TYPE");
		var spr = new Sprite();
		var items = [1, 2];
		var one = 1;
		var str = "string";
		
		trace("OBJECT CHECK:");
		trace("spr is an object: " + Reflect.isObject(spr));
		trace("items is an object: " + Reflect.isObject(items));
		trace("one is an object: " + Reflect.isObject(one));

		trace("FUNCTION CHECK:");
		trace("str is a function: " + Reflect.isFunction(str));
		trace("func is a function: " + Reflect.isFunction(func));

		trace("TYPE LOOKUP:");
		trace("one is a: " + Type.typeof(one));
		trace("items is a: " + Type.typeof(items));
		trace("func is a: " + Type.typeof(func));
		trace("str is a: " + Type.typeof(str));
		trace("spr is a: " + Type.typeof(spr));

		trace("CLASSH NAME LOOKUP:");
		trace("str is a: " + Type.getClassName(Type.getClass(str)));
		trace("spr is a: " + Type.getClassName(Type.getClass(spr)));
		
		/**
		 * For loop to iterate all the properties of an object using Reflect
		 * In ActionScript similar loop looks like 'for (var propertyName:int in object)' 
		*/
		var object:Array<Dynamic> = [{a:1, b:2}, {a:1, b:2}, {a:1, b:2}];
		var fields = Reflect.fields(object);
		for (a in fields) {
			//trace(a);
		}
	}
	
	public static function func():Void { }
	
	/**
	 * The major difference with switch in Haxe is there is no need of a 'break' command for each case.
	 * switch block is automatically exited after the execution on successful case, hence 'break' is not required
	 * Also multible cases can be seperated by , (ex: case 65, 90:)
	*/
	function switchCase():Void {
		trace("SWITCH CASE");
		var v:Int = 90; //play with the values to see which case executes
		switch(v) {
			case 0:
				trace("SWITCH 0 EXECUTED: " + v);
			case 65, 90:
				trace("SWITCH 65, 90 EXECUTED: " + v);
			default:
				trace("SWITCH DEFAULT EXECUTED: " + v);
		}
	}
	
	function typeInferenceAndCasting():Void {
		trace("TYPE INFERENCE AND CASTING");
		
		//Type Inference: The variable type of 'hi' here will be 'String' but in ActionScript it will be treated as Object
		var hi = "hi";
		trace("hi is a: " + Type.typeof(hi));
		
		//In ActionScript 'as' keyword can be used to type cast like 'circle As Shape' or Shape(circle)
		var circle = new Shape();
		var bigCircle:Shape = cast circle;
		//or for a safe cast:		
		var bigCircle = cast(circle, Shape);
		
		//ActionScript String(10), Number("10") and int (10.1) cab be represented in Haxe as follows
		var toString = Std.string(10);
		var toNumber = Std.parseFloat("10");
		var toInteger = Std.int(10.1);
	}
	
	/**
	 * ...params can be used in ActionScript where as in Haxe it has to be a Dynamic array
	 * Also to call the function, Reflect is needed to pass the parameters
	 * Reflect.makeVarArgs(restParameters)(1, 2, 3)
	*/
	function restParameters(params:Array<Dynamic>):Void {
		trace("REST PARAMETERS");
		for (i in 0...params.length) {
			trace(i);
		}
	}
	
	function hashTables():Void {
		var table = new Map();				//var table:Object = new Object(); in ActionScript
		table.set("key", 100);				//table["key"] = 100;
		
		trace(table.exists("key"));			//trace(table.hasOwnProperty("key")); in ActionScript
		
		for(key in table.keys()) {			//for(var key:Object in table) { in ActionScript
		   trace(key + " = " + table.get(key));		//trace(key + " = " + table[key]); in ActionScript
		}
		
		table.remove("key");				//delete table["key"]; in ActionScript
		
		
		// Map sample - Int keys with Int values
		var map = new Map();
		map.set(6, 7);
		trace(map.get(6)); // 7
	}
	
	/**
	 * Getters and Setters
	 * In ActionScript, functions can directly be used as getters and setters with 'get' and 'set' keywords
	 * In Haxe, you have to explicitly declare the variable and it's getter and setter function names as shown below
	*/	
	public var x(get, set):Int;
	
	function get_x():Int { //Similar to public function get x():int
		return 1;
	}
 
	function set_x(value:Int):Int { //Similar to public function set x(value:int):void
		return 1;
	}
}
