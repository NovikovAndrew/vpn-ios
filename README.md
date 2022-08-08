# vpn-ios

- [Project bootstrap](#project-bootstrap)

- [Generamba module generation](#generamba-module-generation)

- [Swinject DI workflow](#swinject-di-workflow)

- [Commit style](#commit-style)


### Project bootstrap

For updating carthages use command:
```sh
carthage update --use-xcframeworks --no-use-binaries --platform iOS --cache-builds --verbose
```


### Generamba module generation

In this project is using generamba tool for new module boilerplate code generation. You should install it using `gem` or `brew` (make sure you have ruby and rvm installed).

We generally use `VIPER` for modules which contains these entities in our case:

---

`ViewModel` - data model representing displayed data by the `ViewController` views.

`ViewController` - is of `UIViewController` type. It is responsible for the view lifecycle and displaying/modifying views using `ViewModel` or specific methods like `enableSubmitButton()`. It is recomended to use a separate `View` class for the view specific logic. 

`Router` - responsible for `ViewController` navigation related to the module.

`Interactor` - layer between buisness logic and data interactions like networking.

`Presenter` - responsible for buisness logic. Has a protocol reference to `ViewController`, and never uses `UIKit` stuff. Uses `Interactor`s for networking and simular data manipulations. Uses `Router` for `ViewController` navigation.

`ConfigData` - data model representing needed data for the module when creating it. It is passed to `Presenter`. 

`Configuration` - function block that has a `ModuleInput` as an argument and returns `ModuleOutput`. It is used to configure the module from the place where you instantiate the module.

`Assembly` - creates and returns `ViewController`. Instantiates every other entity needed for the module, and assigns corresponding dependencies. Calls `Configuration` on `Presenter`.

`ViewManager` - responsible for handling `UITableView` logic.

---

I also use `MVP` for simple modules which is the same as `VIPER` but with no `Router` and `Interactor`

#### Generate module script

Use this script for generation modules in project. This script displays all available parameters for module generation. Also you can choose target for module generation, if this target has no `Rambafile` file and `Templates` link icon in folder - script will generate whem or you can setup generamba manually with `./setup_generamba.sh FRAMEWORK_NAME`.

Script consists from 2 files:

 * `generamba.rb` - entry point for module generation, contains main script;
 * `findTarget.rb` - script for analyzing project and find out all separate targets;

Example:


### Swinject DI workflow

See `VPNInject` classes and `SwitchUserNumber` assembly class for details/examples.


### Commit style

As we stated in a badge above, our project is commitizen-friendly. All of our commits follow the [`commitizen format`](https://gist.github.com/stephenparish/9941e89d80e2bc58a153#format-of-the-commit-message):

```
<type>(<optional_scope>): <subject>
<BLANK LINE>
<optional_body>
```

Example:

```
fix(transfers): fixed rerouting bug for cash by code transfer operation

Please see files cash.ts and cash.service.ts and take a look at new private methods. Make sure you understand new rerouting algorithm.
```

```
feat: implemented new authorization logic for trusted users
```

Note that `<scope>` is optional, but we highly encourage to include JIRA ticket ID, for example `STR-777`.

* Make sure you run `npm install` at the beginning

Please use [`commitizen`](http://commitizen.github.io/cz-cli/) command-line tool for generating commit messages if you feel uncomfortable manually writing all these strongly-formatted messages (we all do).
After running `git add`, run `git cz` instead of regular commit command. You will be taken through message building steps.

* [Commitizen docs](http://commitizen.github.io/cz-cli)
*  [Extensive article in russian](https://anvilabs.co/blog/writing-practical-commit-messages/)
*  [Another article russian](https://habr.com/company/yandex/blog/431432/)
