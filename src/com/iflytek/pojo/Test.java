package com.iflytek.pojo;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test {
    private int id;
    private String name;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Test [id=" + id + ", name=" + name + "]";
    }

    public static void main(String[] args) {
//		String reg = "\\d+";
//		Pattern p = Pattern.compile(reg);
//		Matcher m = p.matcher("ddsf34lk2l3ll342l555l33l22");
//		boolean b = m.matches(); // false
//		List<Integer> list = new ArrayList<Integer>();
//		while (m.find()) {
//			String num = m.group();
//			System.out.println("打印的结果为："+num+"---");
//			list.add(Integer.parseInt(num));
//		}
//		System.out.println(m.matches());
//		System.out.println(list);
//		Collections.sort(list);  // Collections 操作集合的工具类
//		System.out.println(list);

//		boolean b1 = m.find();

        String reg = "\\s*";
        Pattern p = Pattern.compile(reg);
        Matcher m = p.matcher("d");
        System.out.println(m.matches());
    }
}
