# isoflow_example

An example Flutter application, using a modified MVU approach, with "Flows" to manage an app wide event based messaging system.

It is an architecture of
1) Everything is a service
2) Everything is concurrent
3) The async keyword doesn't exist in my world anymore :)
4) Inbound queue's turn concurrency into singular data flows
5) Send outbound events to "Flows" for redirection
