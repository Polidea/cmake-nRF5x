#!/usr/bin/env python3

from unittest.loader import TestLoader
from unittest.runner import TextTestRunner

if __name__ == '__main__':
    loader = TestLoader()
    runner = TextTestRunner()
    suites = loader.discover("nrf5_cmake", "*.py", ".")
    runner.run(suites)
