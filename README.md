# Westfield Paginator
_Created by Zhenya Mirkin_ (@emirkin)

This gem provides a common way to paginate results

## Installation

Add this line to your application's _Gemfile_:

```ruby
  gem 'westfield_paginator', git: "https://#{github_auth}@github.com/westfield/westfield_paginator.git", require: false # _github_auth_ is the basic auth string authorizing access to the repository
```

And then execute:

```sh
$ bundle install
```

## Usage

The most common pattern is:
```ruby
  # Wrap paginator around your full set of records
  paginator = Westfield::Paginator.new(retailers, page: params[:page], per_page: params[:per_page])
  # Wrap paginator around your full set of records, leave page and per_page params empty to use default values
  paginator = Westfield::Paginator.new(retailers)
  # Possibly perform transformation on the records to be returned
  data = paginator.paginated_records.map { |retailer| do_something_with_retailer }
  # Return results
  render json: api_response(data: data, meta: paginator.meta)
  # meta contains: page, page_count, total_pages, per_page
```

If you need to generate only the meta portion and don't need to paginate records, you can use the following:
```ruby
  # some_object must respond to the following methods:
  # current_page, per_page, total_pages, total_count
  paginator_meta = Westfield::PaginatorMeta.new(some_object)
  render json: api_response(data: data, meta: paginator_meta.as_json)
```

## Overriding configuration options

The default per page value is 10 and the default maximum per page value is 100 (as specified in `lib/westfield_paginator/config.rb`).  These values can be overridden by adding the following to a configuration file in the `config/initializers` directory:

```ruby
# Configures global settings for pagination
Westfield::Paginator.configure do |config|
  config.default_per_page = 10
end
```
