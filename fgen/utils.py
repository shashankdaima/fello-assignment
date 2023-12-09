def snake_case_to_camel_and_pascal(snake_case_str):
    components = snake_case_str.split('_')
    camel_case_str = components[0] + ''.join(x.title() for x in components[1:])
    pascal_case_str = ''.join(x.title() for x in components)
    return camel_case_str, pascal_case_str
