
1. /opt/homebrew/Cellar/ruby/3.3.5/lib/ruby/3.3.0/bundled_gems.rb:75:in `require': cannot load such file -- rexml/parsers/baseparser (LoadError)

bundle add rexml
bundle update

2. jekyll 3.8.7 | Error:  undefined method `[]' for nil

using jekyll 4.3.4
gem install jekyll



3. /opt/homebrew/Cellar/ruby/3.3.5/lib/ruby/3.3.0/bundled_gems.rb:75:in `require': cannot load such file -- jekyll-paginate (LoadError)


bundle add jekyll-paginate
bundle add jekyll-feed
bundle add jekyll-sitemap

# 最终使用的版本是

```
ruby 3.3.5 (2024-09-03 revision ef084cc8f4) [arm64-darwin23]
jekyll 4.3.4
Bundler version 2.5.18
gem 3.5.18
```

# 安装注意

1. 安装 brew
2. 安装 ruby
3. 安装 jekyll, bundler
4. 在项目下, 执行 `bundle install` `bundle exec jekyll serve`


参考 `https://jekyllrb.com/docs/installation/macos/`

遇到 bug 一定要细看bug, 不要盲目到网上查询答案.
