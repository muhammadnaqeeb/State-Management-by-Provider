# Provider State Management
There is a lot less boiler plate code to write when using Provider, as it is a wrapper around InheritedWidgets. InheritedWidgets is a widget provided by flutter itself to pass data between other widgets.
Using provider we can separate business logic from UI making code much easier to test and maintain.

## TYPES OF PROVIDERS
*	Provider
*	MultiProvider
*	ChangeNotifierProvider
*	StreamProvider
*	FutureProvider
*	ProxyProvider 

### Provider
First one is provider itself. As name suggests provider provides data to widgets below it in the widget tree.
 
To demonstrate it wrap the root of the widget tree with provider. This acts as a store house of data, Now question arise which data, whatever we pass in create argument. It can be string, bool, int even instance of class.
```
void main(){
  runApp(
    Provider(
      create: (context) => 8
      child: const MyApp(),
    ),
  );
}
```
To read this data in a widget we can use `Provider.of<typeOfData>(context)`
What happens behind the scenes is, it goes up the widget tree and finds the provider widget closest with type we return and spits out the data that is stored.

```final data = Provider.of<String>(context);```
 
Now data variable store the data and now we can use it in our app.
If you find this syntax long so you can use the following

```final data = context.watch<String>();```
 
**CODING EXAMPLE**

Passing a data from top of app to another screen using provider

main.dart file
```
void main() {
  runApp(
    Provider(
      create: ((context) => "8"),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SecondScreen()));
          },
          child: Text("2nd Screen"),
        ),
      ],
    );
  }
}

```
SecondScreen.dart
```
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final data = Provider.of<String>(context);
    final data = context.watch<String>();
    return Center(
      child: Container(
        child: Text("$data"),
      ),
    );
  }
}

```



### ChangeNotifierProvider

Unlike the basic Provider widget, ChangeNotifierProvider listens for changes in the model object. When there are changes, it will rebuild any widgets under the Consumer.
Provider is a read-only widget. Which means it cannot modify the value initially pass to it. So how do we modify the values, so answer is by the help of ChangeNotifierProvider.
 
Now we pass ChangeNotifierProvider, and in **create** argument pass in the **data model**.


```
void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}
```


 
In **data model class,** initiate a **private variable**, create a **getter** and a **function** which change the value of that private variable. In this case we increment the value of private variable by 1. 
To make this work properly with ChangeNotifierProvider **extend** the class with **ChangeNotifier** with provides us **notifyListeners()** function. When ever this function is called it notify ChangeNotifierProvider and widgets listening to it are rebuild.
 

If you don’t use notifyListeners, you won’t see any update in UI.

***FUN FACT:** notifyListeners() calls setState behind the scenes.

Other function can also be added in the model class like in our case decrementCounter or reset.
 
 
Getting data is same for all providers, we just need to specify the type of provider properly.
Now in this case we use the getter method to access the data.
 
Now to change the data we use the methods that we create in model class. In this case we can increment the value.
 
 
Lets break it down
Provideer.of<Counter>(context) will return object of Counter class, on this instance we are calling increment function inside of which we call notifyListeners() and this will rebuild the widget since we are listening to it.
But what if we don’t want to listen meaning in don’t want widget to rebuild, so I can set listen: false
 
For a shorter syntax, we can use,
 
**Note:**
* Context.read() cannot be called in build function.
* Context.watch() cannot be called outside build function.
* `Context.watch` should be used whenever all child widgets need a certain value. Because it make entire widgets to rebuild for example when we click on increment button only counter needs to rebuild but in reality even text and floating Button rebuilds.
 
This seem like no big difference but what if you are building twitter like app, and to update the number of likes, you are rebuilding a whole post card. To prevent the unnecessary widget rebuilds rap the changing widget with Consumer widget which will make only widget returning from it rebuilt. Also give Consumer the return <datatype>, and to get data we can use instance/object of return datatype provided to us
 
Don’t forget to remove context.watch calls otherwise it will still rebuild the entire widget.


### StreamProvider
StreamProvider is basically a wrapper around a StreamBuilder. You provide a stream and then then the Consumers get rebuilt when there is an event in the stream.
It will help us manage stream data like Stream<int>, Stream<String>, Stream<CustomClass>
It is a streamBuilder but with lesser boiler plate code.

### Future Provider
FutureProvider is basically just a wrapper around the FutureBuilder widget. You give it some initial data to show in the UI and also provide it a Future of the value that you want to provide. The FutureProvider listens for when the Future completes and then notifies the Consumers to rebuild their widgets.
The FutureProvider tells the Consumer to rebuild after Future<MyModel> completes.

### MultiProvider
Up to now our examples have only used one model object. If you need to provide a second type of model object, you could nest the providers. However, all that nesting is messy. A neater way to do it is to use a MultiProvider.
It accepts the list of provider in the argument.
 
### ProxyProvider
What if you have two models that you want to provide, but one of the models depends on the other one? In that case you can use a ProxyProvider. A ProxyProvider takes the value from one provider and lets it be injected into another provider.
When one of out Provider depends on value from another Provider, we use proxy Provider.

### Provider Fun Fact
You can create as many providers as you want of the same type, but you can access only 1, the one nearest to your Consumer.

