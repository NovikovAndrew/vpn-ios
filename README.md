# vpn-ios

- [Project bootstrap](#project-bootstrap)

- [Generamba module generation](#generamba-module-generation)

- [Swinject DI workflow](#swinject-di-workflow)

- [Commit style](#commit-style)

- [Localization texts workflow](#localization-texts-workflow)

- [Firebase workflow](#firebase-workflow)

- [Design migration AB testing](#design-migration-ab-testing)

- [UI Documentation](#ui-documentation)

- [Local test build upload](#local-upload)


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


### Localization texts workflow

##### First setup

For localization we use [phrase](https://phrase.com/)
[Here](https://help.phrase.com/help/phrase-in-your-terminal) you can install phrase cli
You can see the config file here https://help.phrase.com/help/configuration

##### Contribution

There is no default values, so it is required to add values for languages/ in vpn app

to get new keys from phrase, just run 
`phraseapp pull`

### Firebase workflow

All Firebase analytics events are added to project through `alfa_analytics_generator` project. 

Events are created in json files and then codegenerated into Swift and kotlin enums. `Events` is the name of swift enumeration, which is 1-to-1 namespaced according to provided JSON files. Analytics events are recorded using Facade interface provided by analytics generator:  `AnalyticsFacade`. See its public methods for details. 

Tips: 
* All new features should be developed along with their corresponding analytics events
* Analytics events are usually recorded in Presenter layer inside each module.
* Use dependency injection to incorporate `AnalyticsFacade` in your class

### Design migration AB testing

##### Intro:
Project will enter into Redesign migration development stage, during which a majority of existing app modules will be changed according to new app design. Team has decided to manage design migration incrementally, using A/B testing capabilities of Firebase. Specific modules will be transformed into new design and shown to user depending on which A/B experiment group he belongs to. 

##### Modules

Application will be divided into 5 macro-modules:

- `Auth`
- `Main`
- `Utilities`
- `Networking`
- `VPN-IOS`

##### RemoteConfig

RemoteConfig entry for a specific audience may look like this:

```json
{
    "main": {
        "experimentGroup": "redesign"
    },
    "auth": {
        "experimentGroup": "redesign"
    }
}

// this means that this user will experience redesigned modules in 
// - main macromodule
// - and auth macro-module
```

##### In code

**Rule of thumb**: In application code, experimentable Macro-module will have its own *AB GroupFactory*. Each *AB GroupFactory* has *AB Factory Closure* for all/some of AB Experiment Groups (be default has only one *AB GroupFactory* for `redesign` AB Experiment Group).

| Name               | Class/alias name  |Description  |
|:----------------- |:-------------|:-------------|
| Macro-module   | DesignMigrationMacroModuleFlagId | One of application's main business modules, which contains a number of different regular modules. Redesign migration can be conducted along each macro-module separately    | 
| AB experiment group   | DesignMigrationExperimentGroup | Firebase experiment group to which user will belong during his session. For each experiment group there might be a distinct AB Factory Closure (or might not)  | 
| AB GroupFactory   |  SingleModuleGroupABFactory | Factory containing alternative implementation closures for various app services&modules for each AB experiment group, they will be injected into main dependency container and served to user at runtime. By default, there will only be an implementation closure for `redesign` experiment group  | 
| AB Factory Closure   | SingleModuleABFactoryClosure | Swift closure which prepares implementations for specific service abstractions and registers them in Swinject dependency container passed to this closure. During Swinject dependency container assemble, alternative implementations registered in this factory closures will be served to user (cosmetic changes, UX changes etc) | 

### UI Documentation
link:
https://confluence

Документация по использованию цветов и иконок:
https://confluence

