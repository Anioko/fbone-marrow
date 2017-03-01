from tests import TestCase


class TestFrontend(TestCase):

    def test_show(self):
        self._test_get_request('/', 'index.html')


class TestUser(TestCase):

    def test_home(self):
        self._test_get_request('/user/', 'user/index.html')


class TestError(TestCase):

    def test_404(self):
        response = self.client.get('/404/')
        self.assert404(response)
        self.assertTemplateUsed('errors/page_not_found.html')


class TestAdmin(TestCase):

    def test_index(self):

        self._test_get_request('/admin/', 'admin/index.html')
