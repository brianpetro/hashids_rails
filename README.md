# hashids_rails gem

[![Gem Version](https://badge.fury.io/rb/hashids_rails.svg)](https://badge.fury.io/rb/hashids_rails)
[![Join the chat at https://gitter.im/brianpetro/hashids_rails](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/brianpetro/hashids_rails?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Uses [hashids.rb](https://github.com/peterhellberg/hashids.rb) to store ActiveRecord IDs in URL non-obviously. Heavily based on [obfuscate_id](https://github.com/namick/obfuscate_id).

## Installation
Add the gem to your Gemfile.

```ruby
gem 'hashids_rails'
```

Run bundler.

```shell
bundle install
```

## Usage
In your model, add a single line.

```ruby
class Post < ActiveRecord::Base
  hash_id
end
```

Trying it in `rails console`.

```ruby
> post = Post.create
=> #<Post id: 1, ...>

> post.id
=> 1

> post.hashed_id
=> "v40"
```

In your views, you cannot use `@post.id` to generate links, because as we saw earlier, this is the original id:

```erb
<%= link_to post_path(@post.id) %>
```

Instead of the above, you must use in this way:

```erb
<%= link_to post_path(@post) %>
```

Or also in this other way:

```erb
<%= link_to post_path(id: @post.hashed_id) %>
```

## Customization

  * __salt__: If you want your hash ids to be different than some other website using the same plugin, you can throw a random string, by default is the name of the model. Note that this change means that all hashes will change, therefore any stored static url will be invalid.
  * __min_hash_length__: The smallest possible length of hash, by default is set to `3`.
  * __alphabet__: Possible characters in what will consist the hash, default is a alphanumeric case sensitive string.

```ruby
class Post < ActiveRecord::Base
  hash_id salt: 'bring_your_own_salt', min_hash_length: 5,
    alphabet: 'define_your_own_alphabet'
end
```

## Limitations
* __This is not security__. `hashids_rails` was created to lightly mask record id numbers for the casual user. If you need to really secure your database ids (hint, you probably don't), you need to use real encryption like AES.

## Contributing

### TODO
* write tests
