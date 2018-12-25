# Shruby

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/shruby`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shruby'
```

And then execute:

$ bundle

Or install it yourself as:

```shell
gem install shruby
``` 
OR without gem install
```shell
 git clone https://github.com/atilla777/shruby.git
cd sh ruby
bundle install
```
## Usage (when gem not installed)
Поиск данных по хосту (информация об открытых портах и баннерах)
```shell
bundle exec shruby h 212.73.99.6 -k API_КЛЮЧ
```
Опции shruby можно посмтореть выполнив
```shell
bundle exec shruby help h
```
### Примеры использования
#### Поиск исторических данных по хосту (какие порты были открыты ранее)
Выполнить команды
```shell
cd ~/shruby 
bundle exec shruby h 212.73.99.6 -h > ~/ФАЙЛ.txt -k КЛЮЧ
```
где – это ФАЙЛ – файл с результатом

Скопировать с помощью SCP файл с результатом на хост с Windows и искать в нем (с помощью notepad++) информацию об открытых портах по следующей строке
**"port"=>**
или конкретный номер порта (в данном случае 22)
**"port"=>22**
 
 Дата на которую существовал открытый порт указано в поле (ниже поля)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/shruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
