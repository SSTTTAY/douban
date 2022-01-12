from selenium import webdriver
import time

def get_douban_comments(url):
    comments_list=[]
    login_url="https://accounts.douban.com/login?source=movie"
    user_name="xxxxx"
    password="xxxx"
    driver=webdriver.Chrome()
    driver.get(login_url)
    driver.find_element_by_id('email').clear()
    driver.find_element_by_id('email').send_keys(user_name)
    driver.find_element_by_id('password').clear()
    driver.find_element_by_id('password').send_keys(password)
    captcha_field=raw_input('请打开浏览器输入验证码：')
    driver.find_element_by_id('captcha_field').send_keys(captcha_field)
    driver.find_element_by_class_name('btn-submit').click()
    time.sleep(5)
    driver.get(url)
    driver.implicitly_wait(3)
    n=501
    count=10000
    while True:
        try:
            results=driver.find_element_by_class_name('comment')
            for result in results:
               # author=result.find_elements_by_tag_name('a')[1].text
               comment=result.find_element_by_tag_name('p').text
               comments_list.append(comment+u'n')
               print( u"查找到第%d个评论" % count)
               count +=1
            driver.find_element_by_class_name('next').click()
            print(u'第%d页查找完毕！' %n)
            n+=1
            time.sleep(4)
        except Exception as e:
            print(e)
            break
    with codecs.open('pjl_comment.txt','a',encoding='utf-8') as f:
        f.writelines(comments_list)
    print( u"查找到第%d页，第%d个评论！" %(n,count))
