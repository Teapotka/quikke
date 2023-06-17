![logo](https://github.com/Teapotka/quikke/assets/101627199/cdec5f80-ed3f-4dfd-bcf3-fd2cf7955c76)

### Let's make your learning quikke :tornado:

This repository contains a mobile app developed with Flutter that allows users to learn new words by adding them within the app. The app provides regular reminders to ensure that users don't miss their learning sessions. It includes interactive tests that challenge users to select the correct meaning for a given word from a list of options. Users have the flexibility to customize the intervals and time range of the tests according to their preferences.
See our design in <a href="https://www.figma.com/file/XDRAtG9MBa7O2k3JQ9zA0I/quikke---solo?type=design&node-id=0%3A1&t=il3ZtWLgDHpYCRjh-1">Figma</a>.

## Features

1. **Words Management**: Users can easily add and edit words, mark them with tags within the app, creating a personal repository of vocabulary to learn. Also users can also easily find the right word in their vocabulary thanks to the search field, filters and tags.
2. **Reminder System**: The app sends regular reminders to users, ensuring they don't miss their learning sessions. Reminders are scheduled at an hourly interval, that the user sets up himself.
3. **Interactive Tests**: Users can assess their word comprehension through interactive tests. Each test presents a word along with four potential meanings. Users must select the correct meaning from the options provided.
4. **Customizable Test Settings**: Users have the ability to set up intervals and time ranges for the tests, tailoring the learning experience to their preferences.

## Stack

#### Framework & Language
+ Flutter: `3.7.3`
+ Dart: `2.19.2`
#### Libs:
+ sqflite: `2.2.8+4` - SQLite DB for flutter used to store words and result
+ path_provider: `2.0.15` - is used for getting app location
+ awesome_notifications: `0.7.4+1` - Notification service used to create schedule reminders
+ flutter_launcher_icons: `0.13.1` - is used to set project icons
+ shared_preferences: `2.1.1` - is used to store project settings
+ fl_chart: `0.62.0` - is used to generate charts based on DBs data

## Installation

1. Clone the repository to your local machine by one of this commands: <br/>
`git clone https://github.com/Teapotka/quikke.git` <br/>
`git clone git@github.com:Teapotka/quikke.git`

2. Ensure that you have Flutter installed. For Flutter installation instructions, refer to the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

3. Open the project in your preferred IDE.

4. Run the following command in the terminal to fetch the project dependencies: <br/>
`flutter pub get`

## Contributing

Contributions to the Quikke are welcome! If you encounter any issues or have suggestions for improvement, please feel free to submit a pull request or open an issue in the repository.

When contributing to this repository, please follow the existing code style and commit message conventions. Also, ensure that you have tested your changes thoroughly before submitting a pull request.

## License

The Quikke is open-source software licensed under the [MIT license](https://opensource.org/licenses/MIT). Feel free to modify and distribute the app as per the terms of the license.

## Acknowledgments

We would like to express our gratitude to the Flutter community for their continuous support and the development tools and packages they have provided, which were instrumental in building this app.

Special thanks to all the contributors who have helped improve the Quikke App through their valuable feedback and suggestions.

## Contact

For any inquiries or feedback, please contact us at [tymofii.sukhariev@gmail.com](mailto:tymofii.sukhariev@gmail.com).

## About us

Tymofii Sukhariev - Full stack (Frontend) developer 
      <a href="https://www.linkedin.com/in/tymofii-sukhariev-9630a2244/">
      <img src="https://img.shields.io/badge/LinkedIn-grey?logo=linkedin&logoColor=blue" />
      </a>
      <br/>
Vladyslav Todorchuk - UI/UX developer
 <a href="https://www.behance.net/vladtodorchuk">
      <img src="https://img.shields.io/badge/Behance-grey?logo=behance&logoColor=white" />
      </a>
