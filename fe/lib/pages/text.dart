var aiText = """
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam varius tempus scelerisque. In luctus, est ac tempor ornare, dui eros consequat erat, nec auctor odio felis accumsan nibh. Ut suscipit finibus est, vel faucibus odio imperdiet sit amet. Suspendisse ante mi, tempor at tristique eget, vestibulum in lacus. Praesent sagittis, turpis dictum molestie tempus, massa nisi laoreet ipsum, in cursus lacus odio ac odio. Morbi dignissim tempor quam in maximus. Vestibulum iaculis leo quis ipsum pretium, vel tempus odio finibus. In sodales egestas urna, eu euismod dolor hendrerit eget. Sed bibendum velit eu porttitor hendrerit. Phasellus venenatis aliquet enim, id lacinia eros maximus eu.

Suspendisse cursus lorem et massa sodales, vitae condimentum lorem elementum. Etiam auctor libero non ante imperdiet tincidunt. Fusce porta sagittis tempor. Aliquam vestibulum ac tortor at finibus. Aliquam quis erat lectus. Sed scelerisque mi in eros malesuada, nec rhoncus ex vestibulum. Nulla fermentum lectus id sapien iaculis, eu porta metus tempor. Quisque et ultricies diam. Curabitur non aliquet erat, non venenatis nisl.

Proin facilisis sed mi non condimentum. Pellentesque non ullamcorper leo. Morbi lacus diam, pretium eget venenatis eget, vestibulum at eros. Cras tellus libero, lacinia ac elementum quis, bibendum vel nisi. Praesent convallis placerat neque nec mollis. Integer faucibus metus sit amet lobortis consequat. Curabitur congue, magna pretium eleifend dignissim, nunc tellus varius elit, in fermentum mi mi eu magna. Vivamus posuere mauris ac ligula consectetur tincidunt. Ut ullamcorper libero eu tortor viverra dictum. Sed purus mauris, consectetur vel venenatis sit amet, imperdiet id est. Praesent vehicula nisi purus, a gravida arcu tempor non. Mauris sem turpis, vestibulum vel odio non, placerat accumsan erat. In nisi urna, feugiat eget mauris nec, ultricies pulvinar purus. Mauris sem diam, malesuada vel erat vel, tincidunt mattis elit. Vestibulum tempor, nulla et cursus sagittis, nisi sapien cursus metus, ut cursus eros leo feugiat magna. Pellentesque sem ipsum, rhoncus et interdum nec, lobortis non elit.

Quisque suscipit gravida tellus a scelerisque. Nam fringilla posuere pharetra. Donec vel aliquam sem. Etiam iaculis feugiat ultrices. Donec eleifend mattis nisl finibus euismod. Quisque fermentum arcu a orci semper, a placerat lectus mollis. Nullam interdum purus sed nisi egestas porta. Curabitur elementum mi metus, id porttitor nunc pellentesque a. Donec a sodales nibh. Pellentesque a purus et lorem viverra fermentum. Suspendisse potenti. 
""";

var userText = """
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam varius tempus scelerisque. In luctus, est ac tempor ornare, dui eros consequat erat, nec auctor odio felis accumsan nibh. Ut suscipit finibus est, vel faucibus odio imperdiet sit amet. Suspendisse ante mi, tempor at tristique eget, vestibulum in lacus. Praesent sagittis, turpis dictum molestie tempus, massa nisi laoreet ipsum, in cursus lacus odio ac odio. Morbi dignissim tempor quam in maximus. Vestibulum iaculis leo quis ipsum pretium, vel tempus odio finibus. In sodales egestas urna, eu euismod dolor hendrerit eget. Sed bibendum velit eu porttitor hendrerit. Phasellus venenatis aliquet enim, id lacinia eros maximus eu.Suspendisse cursus lorem et massa sodales, vitae condimentum lorem elementum. Etiam auctor libero non ante imperdiet tincidunt. Fusce porta sagittis tempor. Aliquam vestibulum ac tortor at finibus. Aliquam quis erat lectus. Sed scelerisque mi in eros malesuada, nec rhoncus ex vestibulum. Nulla fermentum lectus id sapien iaculis, eu porta metus tempor. Quisque et ultricies diam. Curabitur non aliquet erat, non venenatis nisl.Proin facilisis sed mi non condimentum. Pellentesque non ullamcorper leo. Morbi lacus diam, pretium eget venenatis eget, vestibulum at eros. Cras tellus libero, lacinia ac elementum quis, bibendum vel nisi. Praesent convallis placerat neque nec mollis. Integer faucibus metus sit amet lobortis consequat. Curabitur congue, magna pretium eleifend dignissim, nunc tellus varius elit, in fermentum mi mi eu magna. Vivamus posuere mauris ac ligula consectetur tincidunt. Ut ullamcorper libero eu tortor viverra dictum. Sed purus mauris, consectetur vel venenatis sit amet, imperdiet id est. Praesent vehicula nisi purus, a gravida arcu tempor non. Mauris sem turpis, vestibulum vel odio non, placerat accumsan erat. In nisi urna, feugiat eget mauris nec, ultricies pulvinar purus. Mauris sem diam, malesuada vel erat vel, tincidunt mattis elit. Vestibulum tempor, nulla et cursus sagittis, nisi sapien cursus metus, ut cursus eros leo feugiat magna. Pellentesque sem ipsum, rhoncus et interdum nec, lobortis non elit.Quisque suscipit gravida tellus a scelerisque. Nam fringilla posuere pharetra. Donec vel aliquam sem. Etiam iaculis feugiat ultrices. Donec eleifend mattis nisl finibus euismod. Quisque fermentum arcu a orci semper, a placerat lectus mollis. Nullam interdum purus sed nisi egestas porta. Curabitur elementum mi metus, id porttitor nunc pellentesque a. Donec a sodales nibh. Pellentesque a purus et lorem viverra fermentum. Suspendisse potenti. 
""";