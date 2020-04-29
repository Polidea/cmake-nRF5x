from unittest import TestCase


class Version:
    def __init__(self, major: int, minor: int, patch: int):
        self._major = major
        self._minor = minor
        self._patch = patch

    @staticmethod
    def from_string(version: str):
        return Version(*(int(x) for x in version.split('.')))

    def __str__(self):
        return str(self._major) + "." + str(self._minor) + "." + str(self._patch)

    def __cmp__(self, other):
        major_diff = self._major - other._major
        if major_diff != 0:
            return major_diff
        minor_diff = self._minor - other._minor
        if minor_diff != 0:
            return minor_diff
        return self._patch - other._patch

    def __eq__(self, other):
        if not isinstance(other, Version):
            return False
        return self.__cmp__(other) == 0

    def __lt__(self, other):
        return self.__cmp__(other) < 0

    def __le__(self, other):
        return self.__cmp__(other) <= 0

    def __gt__(self, other):
        return self.__cmp__(other) > 0

    def __ge__(self, other):
        return self.__cmp__(other) >= 0

    @property
    def major(self) -> int:
        return self._major

    @property
    def minor(self) -> int:
        return self._minor

    @property
    def patch(self) -> int:
        return self._patch


class VersionTestCase(TestCase):
    def test_equality(self):
        self.assertEqual(Version(16, 0, 0), Version(16, 0, 0))
        self.assertNotEqual(Version(16, 0, 0), Version(16, 0, 1))
        self.assertNotEqual(Version(16, 0, 0), Version(16, 1, 0))
        self.assertNotEqual(Version(16, 0, 0), Version(17, 0, 0))

    def test_less(self):
        self.assertLess(Version(16, 0, 0), Version(16, 0, 1))
        self.assertLess(Version(16, 0, 0), Version(16, 1, 0))
        self.assertLess(Version(16, 0, 0), Version(17, 0, 0))

    def test_greater(self):
        self.assertGreater(Version(16, 0, 1), Version(16, 0, 0))
        self.assertGreater(Version(16, 1, 0), Version(16, 0, 0))
        self.assertGreater(Version(17, 0, 0), Version(16, 0, 0))

    def test_text_format(self):
        self.assertEqual(Version.from_string("13.4.5"), Version(13, 4, 5))
        self.assertEqual("13.4.5", str(Version(13, 4, 5)))

    def test_getters(self):
        version = Version(13, 4, 5)
        self.assertEqual(version.major, 13)
        self.assertEqual(version.minor, 4)
        self.assertEqual(version.patch, 5)
