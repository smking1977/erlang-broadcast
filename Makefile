PROJECT = sb
DEPS = cowboy gproc jsx gun erlang-uuid 

dep_jsx = git https://github.com/talentdeficit/jsx.git
dep_erlang-uuid = git https://github.com/avtobiff/erlang-uuid.git

include erlang.mk
