[![Travis CI](https://travis-ci.org/meurio/legislando.svg?branch=master)](https://travis-ci.org/meurio/legislando)
[![Code Climate](https://codeclimate.com/github/meurio/legislando/badges/gpa.svg)](https://codeclimate.com/github/meurio/legislando)
[![Code Climate Coverage](https://codeclimate.com/github/meurio/legislando/badges/coverage.svg)](https://codeclimate.com/github/meurio/legislando)

# Install

We are using [Docker Compose](https://docs.docker.com/compose/) to run Legislando in the localhost.

In order to get it up and running you will first have to [install Docker](https://docs.docker.com/installation/ubuntulinux/) and all it's dependencies.

After installing Docker it's time to install Compose, follow [this tutorial](https://docs.docker.com/compose/install/) to get it installed.

Equipped with Docker and Composer you can now jump in the Legislando project folder and run:

```
docker-compose build
```

This command will set up a virtual machine to run the web service and the database of Legislando.

Copy ```database.sample.yml``` to ```database.yml``` so the we will be able to create the database in the next step.

```
cp config/database.sample.yml config/database.yml
```

Next you will create and migrate the database, so you have to run:

```
docker-compose run web bundle exec rake db:create
```

Followed by:

```
docker-compose run web bundle exec rake db:migrate
```

And finally you will start the web service running:

```
docker-compose up
```

If all goes right you will see something like this in your terminal:

![docker-compose up](http://i.imgur.com/LOUjVrg.png)

Now run:

```
boot2docker ip
```

To get the IP address Docker is listening, mine is ```192.168.59.103``` so if I hit [http://192.168.59.103:3000/](http://192.168.59.103:3000/) in the browser I'll get the home page of Legislando.

That's it! If you have any trouble with this installation drop a line in the [issues](https://github.com/meurio/legislando/issues) and we will be glad to help.
