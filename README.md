
# Metakoans

### To run the task type the following:
### $ ruby metakoans.rb ./knowledge.rb

 metakoans.rb is an arduous set of exercises designed to stretch meta-programming muscle.  the focus is on a single method 'attribute' which behaves much like the built-in 'attr', but whose properties require delving deep into the depths of meta-ruby.  usage of the 'attribute' method follows the general form of
```ruby
   class C
     attribute 'a'
   end

   o = C::new
   o.a = 42   # setter - sets @a
   o.a        # getter - gets @a
   o.a?       # query - true if @a
```
 but reaches much farther than the standard 'attr' method as you will see shortly.

 your path, should you choose to follow it, is to write a single file 'knowledge.rb' implementing all functionality required by the koans below. as a student of meta-programming your course will be guided by a guru whose wisdom and pithy sayings will assist you on your journey.

 a successful student will eventually be able to do this
```
   harp:~ > ruby metakoans.rb knowledge.rb
   koan_1 has expanded your awareness
   koan_2 has expanded your awareness
   koan_3 has expanded your awareness
   koan_4 has expanded your awareness
   koan_5 has expanded your awareness
   koan_6 has expanded your awareness
   koan_7 has expanded your awareness
   koan_8 has expanded your awareness
   koan_9 has expanded your awareness
   mountains are again merely mountains
```
