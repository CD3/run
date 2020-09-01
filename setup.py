from distutils.core import setup
setup(
    name = 'qrun',
    version = '0.5.0',
    license='MIT',
    description = 'A small utility for running multiple jobs in parallel or series.',
    author = 'CD Clark III',
    author_email = 'clifton.clark@gmail.com',
    url = 'https://github.com/CD3/run',
    install_requires=[],
    classifiers=[
      "Programming Language :: Python :: 3",
      "License :: OSI Approved :: MIT License",
      "Operating System :: OS Independent",
      ],
    python_requires='>=3.0',
    entry_points='''
      [console_scripts]
      qrun=qrun.scripts:qrun
      qrun-util=qrun.scripts:qrun_util
    ''',
    )
