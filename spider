# -*- coding: utf-8 -*-
"""
Created on Fri Jul 14 10:51:35 2017

@author: tangshihua
"""
from urllib.request import urlopen
from bs4 import BeautifulSoup
import requests
import re
import time
import sys
import urllib
import codecs
import jieba
import jieba.analyse as analyse
from wordcloud import WordCloud
from scipy.misc import imread


#获取网页信息
def getHTMLText(url,k):
    try:
        if(k==0):kw={}
        else: kw={'start':k}
        r = s.get(url,params=kw,headers={'User-Agent': 'Mozilla/4.0'})
        r.raise_for_status()
        r.encoding = r.apparent_encoding
        return r.text
    except:
        print("Failed!")
        
#解析网页，获得评论内容       
def getData(html,comments):
    bs1=BeautifulSoup(html,"html.parser")
    commentlist=comments
    comment=bs1.findAll('p',{'class':""})
    i=0
    for com in comment:
        if i <20:
            commentlist.append(com.get_text())
            i+=1
    j=0
    #将评论内容保存至本地文件
    with codecs.open('D:\pythontest\comment.txt','w') as f:
        f.writelines(commentlist)
        f.close() 
     
