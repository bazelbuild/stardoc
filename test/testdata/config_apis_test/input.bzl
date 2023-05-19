# buildifier: disable=module-docstring
# buildifier: disable=function-docstring
def exercise_the_api():
    _unused = configuration_field(fragment = "cpp", name = "custom_malloc")  # @unused

exercise_the_api()

def transition_func(settings):
    """A no-op transition function."""
    return settings

my_transition = transition(implementation = transition_func, inputs = [], outputs = [])

def _build_setting_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

string_flag = rule(
    doc = "A string flag.",
    implementation = _build_setting_impl,
    build_setting = config.string(flag = True),
)

int_setting = rule(
    doc = "An integer flag.",
    implementation = _build_setting_impl,
    build_setting = config.int(flag = False),
)
