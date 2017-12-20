#!/usr/bin/python
# -*- coding: utf-8 -*-

import os

import appier
import appier_extras

import proyectos

class BaseController(appier.Controller):

    @appier.route("/render/<str:repo>", "GET")
    def render_base(self, repo):
        return self.redirect(
            self.url_for("base.render", repo = repo)
        )

    @appier.route("/render/<str:repo>/", "GET")
    @appier.route("/render/<str:repo>/<regex('[\:\.\/\s\w-]+'):page>.md", "GET")
    def render(self, repo, page = None):
        theme = appier.conf("THEME", None)
        theme = self.field("theme", theme)

        _repo = self._repo(repo)
        name = _repo.name
        description = _repo.description
        github = None if page else _repo.html_url
        ga = _repo.ga or appier.conf("GA")
        repo_path = _repo.repo_path()
        index_path = _repo.index_path()
        page_path = os.path.join(repo_path, page + ".md") if page else index_path

        if page: title = "%s / %s" % (_repo.repr(), page.split("/")[-1])
        else: title = _repo.repr()

        if not os.path.exists(page_path): raise appier.NotFoundError(
            message = "Page '%s' not found in repository" % page_path
        )

        buffer = appier.legacy.StringIO()
        parser = appier_extras.MarkdownParser()
        generator = appier_extras.MarkdownHTML(file = buffer, encoding = None)

        file = open(page_path, "rb")
        try: contents = file.read()
        finally: file.close()

        nodes = parser.parse(contents)
        generator.generate(nodes)

        value = buffer.getvalue()
        buffer.close()

        return self.template(
            "markdown.html.tpl",
            theme = theme,
            name = name,
            title = title,
            description = description,
            contents = value,
            github = github,
            ga = ga
        )

    @appier.route("/render/<str:repo>/favicon.ico", "GET")
    def favicon(self, repo):
        _repo = self._repo(repo, rules = False)
        favicon = _repo.favicon
        if not favicon: return self.send_static("images/favicon.ico")
        else: return self.send_file(
            favicon.data,
            content_type = favicon.mime,
            etag = favicon.etag
        )

    @appier.route("/render/<str:repo>/<regex('[\:\.\/\s\w-]+'):reference>", "GET")
    def resource(self, repo, reference):
        _repo = self._repo(repo)
        repo_path = _repo.repo_path()
        resource_path = os.path.join(repo_path, reference)
        return self.send_path(resource_path, url_path = reference)

    @classmethod
    def _repo(cls, repo, status = True, rules = True, raise_e = True):
        _repo = None
        alias_l = set((repo, repo.replace("_", "-"), repo.replace("-", "_")))

        for alias in alias_l:
            _repo = proyectos.Repo.get(
                name = alias,
                status = status,
                rules = rules,
                raise_e = False
            )
            if not _repo: continue
            break

        if raise_e and not _repo: raise appier.NotFoundError(
            message = "Repository '%s' not found" % (repo)
        )

        return _repo
