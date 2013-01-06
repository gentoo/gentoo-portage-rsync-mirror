# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/ownpaste/ownpaste-9999.ebuild,v 1.4 2012/12/26 23:30:45 ottxor Exp $

EAPI=4

PYTHON_COMPAT="python2_7"

HG_ECLASS=""
if [[ ${PV} = *9999* ]]; then
	HG_ECLASS="mercurial"
	EHG_REPO_URI="http://hg.rafaelmartins.eng.br/ownpaste/"
fi

inherit python-distutils-ng ${HG_ECLASS}

DESCRIPTION="Private pastebin (server-side implementation)"
HOMEPAGE="http://ownpaste.rtfd.org/ http://pypi.python.org/pypi/ownpaste"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

RDEPEND="dev-python/setuptools
	>=dev-python/flask-0.8
	>=dev-python/flask-script-0.3.3
	>=dev-python/flask-sqlalchemy-0.15
	>=dev-python/jinja-2.6
	>=dev-python/werkzeug-0.8
	>=dev-python/sqlalchemy-migrate-0.7.2
	dev-python/pygments
	dev-python/pytz"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

src_compile() {
	python-distutils-ng_src_compile

	if use doc; then
		einfo 'building documentation'
		emake -C docs html
	fi
}

src_install() {
	python-distutils-ng_src_install

	if use doc; then
		einfo 'installing documentation'
		dohtml -r "${S}/docs/_build/html/"*
	fi
}
