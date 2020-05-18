from setuptools import setup, find_packages

with open('requirements.txt') as f:
    requires = f.read().splitlines()

setup(
    name='Regulatorycircuits-lod website',
    version='0.0.1',
    description='Regulatorycircuits-lod website',
    classifiers=[
        "Programming Language :: Python",
        "Topic :: Internet :: WWW/HTTP",
    ],
    maintainer='Xavier Garnier',
    url='https://regulatorycircuits-lod.genouest.org/',
    packages=find_packages(),
    include_package_data=True,
    install_requires=requires,
)
