"""Tests for functions which use *args or **kwargs"""

def macro_with_kwargs(name, config, deps = [], **kwargs):
    """My kwargs macro is the best.

    This is a long multi-line doc string.
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer
    elementum, diam vitae tincidunt pulvinar, nunc tortor volutpat dui,
    vitae facilisis odio ligula a tortor. Donec ullamcorper odio eget ipsum tincidunt,
    vel mollis eros pellentesque.

    Args:
      name: The name of the test rule.
      config: Config to use for my macro
      deps: List of my macro's dependencies
      **kwargs: Other attributes to include

    Returns:
      An empty list.
    """
    _ignore = [name, config, deps, kwargs]  # @unused
    return []

def macro_with_args(name, *args):
    """My args macro is OK.

    Args:
      name: The name of the test rule.
      *args: Other arguments to include

    Returns:
      An empty list.
    """
    _ignore = [name, args]  # @unused
    return []

def macro_with_both(name, number = 3, *args, **kwargs):
    """Oh wow this macro has both.

    Not much else to say.

    Args:
      name: The name of the test rule.
      number: Some number used for important things
      *args: Other arguments to include
      **kwargs: Other attributes to include

    Returns:
      An empty list.
    """
    _ignore = [name, number, args, kwargs]  # @unused
    return []

# buildifier: disable=unused-variable
def macro_with_only_args(*args):
    """Macro only taking *args

    Args:
      *args: Positional arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_only_kwargs(**kwargs):
    """Macro only taking **kwargs

    Args:
      **kwargs: Named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_only_args_and_kwargs(*args, **kwargs):
    """Macro only taking *args and **kwargs

    Args:
      *args: Positional arguments
      **kwargs: Named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_kwonly(*, name):
    """One keyword-only param

    Args:
      name: The name
    """
    pass

# buildifier: disable=unused-variable
def macro_with_kwonlys(*, name, number = 3):
    """Several keyword-only params

    Args:
      name: The name
      number: The number
    """
    pass

# buildifier: disable=unused-variable
def macro_with_kwonly_and_kwargs(*, name, **kwargs):
    """One keyword-only param and **kwargs

    Args:
      name: The name
      **kwargs: Other named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_kwonlys_and_kwargs(*, name, number = 3, **kwargs):
    """Several keyword-only params and **kwargs

    Args:
      name: The name
      number: The number
      **kwargs: Other named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_params_and_kwonly(name, number = 3, *, config):
    """Several ordinary params and a keyword-only param

    Args:
      name: The name
      number: The number
      config: Configuration
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_param_and_kwonlys(name, *, number, config):
    """One ordinary param and several keyword-only params

    Args:
      name: The name
      number: The number
      config: Configuration
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_param_kwonlys_and_kwargs(name, *, number, config, **kwargs):
    """One ordinary param, several keyword-only params, and **kwargs

    Args:
      name: The name
      number: The number
      config: Configuration
      **kwargs: Other named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_params_kwonly_and_kwargs(name, number = 3, *, config, **kwargs):
    """Several ordinary params, a keyword-only param, and **kwargs

    Args:
      name: The name
      number: The number
      config: Configuration
      **kwargs: Other named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_args_and_kwonly(*args, name):
    """*args and a keyword-only param

    Args:
      *args: Positional arguments
      name: The name
    """
    pass

# buildifier: disable=unused-variable
def macro_with_args_and_kwonlys(*args, name, number = 3):
    """*args and several keyword-only params

    Args:
      *args: Positional arguments
      name: The name
      number: The number
    """
    pass

# buildifier: disable=unused-variable
def macro_with_args_kwonly_and_kwargs(*args, name, **kwargs):
    """*args, a keyword-only param, and **kwargs

    Args:
      *args: Positional arguments
      name: The name
      **kwargs: Other named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_args_kwonlys_and_kwargs(*args, name, number = 3, **kwargs):
    """*args, several keyword-only params, and **kwargs

    Args:
      *args: Positional arguments
      name: The name
      number: The number
      **kwargs: Other named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_params_args_and_kwonly(name, number = 3, *args, config):
    """Several ordinary params, *args, and a keyword-only param

    Args:
      name: The name
      number: The number
      *args: Positional arguments
      config: Configuration
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_param_args_and_kwonlys(name, *args, number, config):
    """One ordinary param, *args, and several keyword-only params

    Args:
      name: The name
      *args: Positional arguments
      number: The number
      config: Configuration
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_param_args_kwonlys_and_kwargs(name, *args, number, config, **kwargs):
    """One ordinary param, *args, several keyword-only params, and **kwargs

    Args:
      name: The name
      *args: Other positional arguments
      number: The number
      config: Configuration
      **kwargs: Other named arguments
    """
    pass

# buildifier: disable=unused-variable
def macro_with_ordinary_params_args_kwonly_and_kwargs(name, number = 3, *args, config, **kwargs):
    """Several ordinary params, *args, one keyword-only param, and **kwargs

    Args:
      name: The name
      number: The number
      *args: Other positional arguments
      config: Configuration
      **kwargs: Other named arguments
    """
    pass
