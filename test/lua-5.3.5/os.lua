print "test\n"

local suc, t, val = os.execute()
assert(suc == true)
assert(t == nil)
assert(val == nil)

suc, t, val = os.execute('echo "Hello Lua World!"')
assert(suc == true)
assert(t == 'exit')
assert(val == 0)

suc, t, val = os.execute('not_a_command')
assert(suc == nil)
assert(t == 'exit')
assert(val == 1)
