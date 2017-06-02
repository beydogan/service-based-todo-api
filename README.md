# Service Object Based TODO API Example 

This is a POC project to demonstrate service object based APIs (not sure if that's a thing, I just made it up) 

# Idea

Service objects is a common practice to reduce size of controllers and models in Rails applications by moving & splitting business logic into individual classes. 
It also makes things easier to test. Your services might be POROs(Plan Old Ruby Object) or you can use some gems like mutations, services, interactor. 
  
The main idea is; if you want to make a JSON API with Rails, you can have single endpoint to handle all requests. Yes, just one endpoint. 
In this example, we have a `Api::ApiController` controller class with a single action `call`. 
It receives the requests and calls the specified service object and returns the result.(Single responsibility principle)

# Request => Service

Basically `ApiController` maps the requests to the service objects. API routes has a template;
 
`/api/call/:namespace/:command`
 
**namespace** might be `Todos`, `Users`, `Categories`, `Posts`, its something to categorize your services, in our example its just plural of our model `Todo`

**command** might be `create`, `update`, `delete`, `index`, `show`, `toggle`, it describes what does the service on that namespace.

You can pass query or body parameters with GET, POST, PUT, DELETE requests, `ApiController` will pass those parameters to the service objects while calling them.
 
### Example

Lets say we have the following HTTP Request;
```
POST /api/call/todos/create
title=Hello World&deadline=25/06/2017
```

This request will hit the `ApiController`'s `call` action. Controller will make the following call;

```ruby
Todos::Create.run(title: "Hello World", deadline: "25/06/2017")
``` 

And we have the `Todos::Create` class defined in `app/commands/todos/create.rb` it has only one job: creating a todo with given parameters.

```ruby
module Todos
  class Create < ::ApplicationCommand

    required do
      string :title
      string :deadline
    end

    def execute
      todo = Todo.create!(title: title, deadline: deadline)

      # Add Callbacks here

      todo
    end
  end
end
```
**todos/create.rb**

# Extending

You need another action? Let's say we need something to toggle status of todos. Just create a new class in `todos` called `toggle.rb`.
 
```ruby
module Todos
 class Toggle < ::ApplicationCommand

   required do
     integer :id
   end

   def execute
     todo = Todo.find(id)
     todo.update!(completed: !todo.completed)

     # Add Callbacks here

     todo
   end
 end
end
```

You don't need any change on your `routes.rb`. You can use `/api/call/todos/toggle` endpoint to make a call.

The HTTP Request would be;
```
POST /api/call/todos/toggle
id=1
```





