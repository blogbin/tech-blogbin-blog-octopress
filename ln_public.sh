rm -r public/blog
ln -s public/tech-blogbin-blog/blog public/blog

rm -r public/assets
ln -s public/tech-blogbin-blog/assets public/assets

rm -r public/atom.xml
ln public/tech-blogbin-blog/atom.xml public/atom.xml

rm -r public/favicon.png
ln public/tech-blogbin-blog/favicon.png public/favicon.png

rm -r public/images
ln -s public/tech-blogbin-blog/images public/images

rm -r public/index.html
ln public/tech-blogbin-blog/index.html public/index.html

rm -r public/javascripts
ln -s public/tech-blogbin-blog/javascripts public/javascripts

rm -r public/sitemap.xml
ln public/tech-blogbin-blog/sitemap.xml public/sitemap.xml

rm -r public/stylesheets
ln -s public/tech-blogbin-blog/stylesheets public/stylesheets
