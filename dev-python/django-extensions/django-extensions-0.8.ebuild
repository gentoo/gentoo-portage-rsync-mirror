# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-extensions/django-extensions-0.8.ebuild,v 1.1 2012/05/09 19:09:42 neurogeek Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

GIT_HASH_TAG="0f498ff"
PYTHON_MODNAME="django_extensions"

DESCRIPTION="Django Command Extensions"
HOMEPAGE="http://github.com/django-extensions/django-extensions http://code.google.com/p/django-command-extensions/"
SRC_URI="http://github.com/django-extensions/django-extensions/tarball/${PV}/${P}.tgz"

LICENSE="BSD || ( MIT GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc graphviz mysql postgres s3 sqlite vcard"

RDEPEND="dev-python/django[mysql?,postgres?,sqlite?]
	dev-python/pygments
	dev-python/werkzeug
	graphviz? ( dev-python/pygraphviz )
	s3? ( dev-python/boto )
	vcard? ( dev-python/vobject )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${PN}-${PN}-${GIT_HASH_TAG}"

DOCS="docs/AUTHORS docs/*.rst"

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake -C docs html || die "generating html docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/_build/html/*
}
