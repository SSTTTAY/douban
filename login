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
s = requests.Session()
url1 = 'https://accounts.douban.com/login'
url2 = 'https://movie.douban.com/subject/26387939/comments?sort=new_score&status=P'

formdata={
  "redir":"https://www.douban.com/",
  "form_email":"15627868532",
  "form_password":"ll19960918",
  #'captcha-solution':'blood',
  #'captcha-id':'cRPGXEYPFHjkfv3u7K4Pm0v1:en',
  "login":u"登录"
  } 

headers = {
  "user-agent":"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36"
#"Location": "https://accounts.douban.com/login"
  }
 
r1 = s.post(url1,data=formdata,headers=headers)      #发送登录请求
rcontent = r1.text

soup = BeautifulSoup(rcontent,"html.parser")

#如需验证码
captchaAddr = soup.find('img',id='captcha_image')['src']
if captchaAddr != None:
    reCaptchaID = r'<input type="hidden" name="captcha-id" value="(.*?)"/'
    captchaID = re.findall(reCaptchaID,rcontent)
    print(captchaID)
    urllib.request.urlretrieve(captchaAddr,"captcha.jpg")
    captcha = input('please input the captcha:')
    formdata['captcha-solution'] = captcha
    formdata['captcha-id'] = captchaID
    r1 = s.post(url1,data=formdata,headers=headers)      

#获取页面信息
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

#解析爬取的页面
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
    with codecs.open('D:\pythontest\comment.txt','w') as f:
        f.writelines(commentlist)
        f.close()
     
      
#获取关键字        
def get_top_keywords(file_name):
    top_word_lists = [] # 关键词列表
    with codecs.open(file_name,'r',encoding='utf-8') as f:
        texts = f.read() # 读取整个文件作为一个字符串
        Result = analyse.textrank(texts,topK=20,withWeight=True,withFlag=True)
        n = 1
        for result in Result:
            print( u"%d:" % n ,)
            for C in result[0]: # result[0] 包含关键词和词性
                print (C,u"  ",)
            print( u"权重:"+ unicode(result[1]) )# 关键词权重
            n += 1   

k=0
comments=[]
while k<=225:
    html=getHTMLText(url2,k)
    time.sleep(2)
    k+=20
    getData(html,comments)
